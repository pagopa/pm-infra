locals {
  vm_count = 2 # Set this param to increase/decrease vm scaling
}

data "azurerm_resource_group" "vmrg" {
  name = var.vmrg
}

data "azurerm_resource_group" "rg_vnet" {
  name = var.network_resource
}

data "azurerm_virtual_network" "vm_vnet" {
  name                = var.vm_network_name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_subnet" "vm_subnet" {
  name                 = "default"
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vm_vnet.name
}

resource "azurerm_network_interface" "vm_nic" {
  count               = local.vm_count
  name                = format("%s0%s-nic-%s", var.vm_name, count.index + 1, var.environment)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = format("%s%s", var.vm_ip, count.index + var.ip_shift)
  }
}

# Creating the Key by importing the SSH private key
resource "azurerm_key_vault_secret" "sshkey" {
  name            = "prikey-vm-bridge"
  value           = base64encode(file("~/.ssh/id_rsa"))
  key_vault_id    = data.azurerm_key_vault.keyvault.id
  content_type    = "rsa_key"
  expiration_date = "2122-11-22T00:50:52Z"

  tags = {
    kind      = "vault key",
    standard  = var.standard,
    TS_Code   = var.tsi,
    CreatedBy = "Terraform"
  }
}


resource "azurerm_linux_virtual_machine" "vm" {
  count                      = local.vm_count
  name                       = format("%s0%s", var.vm_name, count.index + 1)
  resource_group_name        = data.azurerm_resource_group.vmrg.name
  location                   = data.azurerm_resource_group.vmrg.location
  size                       = var.vm_size[count.index]
  zone                       = count.index + 1
  admin_username             = data.azurerm_key_vault_secret.admin-user.value
  admin_password             = data.azurerm_key_vault_secret.admin-password.value
  encryption_at_host_enabled = true
  network_interface_ids = [
    azurerm_network_interface.vm_nic[count.index].id,
  ]

  admin_ssh_key {
    username   = data.azurerm_key_vault_secret.admin-user.value
    public_key = file("~/.ssh/id_rsa.pub")
  }

  disable_password_authentication = false

  os_disk {
    caching                = "ReadWrite"
    storage_account_type   = "Premium_LRS"
    disk_encryption_set_id = data.azurerm_disk_encryption_set.encset.id
    disk_size_gb           = "128"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7.6"
    version   = "latest"
  }

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = self.admin_username
    password = self.admin_password
    host     = self.private_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo useradd ddsdbadmin",
      "sudo usermod -aG wheel ddsdbadmin",
      "sudo echo 'ddsdbadmin:Password10!' | sudo chpasswd",
      "sudo su - root -c \"echo 'ddsdbadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/90-cloud-init-users\"",
      "sudo yum update -y"
    ]
  }

  boot_diagnostics {
    storage_account_uri = "https://diagnosticvmdiskuat.blob.core.windows.net/"
  }

  tags = {
    kind        = "virtual machine",
    environment = var.environment,
    standard    = var.standard,
    TS_Code     = var.tsi,
    CreatedBy   = "Terraform"
  }

}

##========================================================================================
##                                                                                      ##
## DATA DISKS                                                                           ##
##                                                                                      ##
##========================================================================================

##──── data disk mapping ─────────────────────────────────────────────────────────────────
locals {
  vm_datadiskdisk_count_map = { for k, i in azurerm_linux_virtual_machine.vm.*.id : i => k }
  datadisk_lun_map = flatten([
    for vm, idx in local.vm_datadiskdisk_count_map : [
      for d in var.disk_oracle_data : {
        datadisk_name = format("oracle-data-%s-%s-%s", azurerm_linux_virtual_machine.vm[idx].name, d.lun, d.tier)
        lun           = d.lun
        size          = d.size
        tier          = d.tier
        vmid          = vm
        zone          = tostring(azurerm_linux_virtual_machine.vm[idx].zone)
      }
    ]
  ])
}

##──── Resource declaration ──────────────────────────────────────────────────────────────
resource "azurerm_managed_disk" "oracle_data" {
  depends_on             = [azurerm_linux_virtual_machine.vm]
  for_each               = { for i, v in local.datadisk_lun_map : i => v }
  name                   = each.value["datadisk_name"]
  location               = data.azurerm_resource_group.vmrg.location
  resource_group_name    = data.azurerm_resource_group.vmrg.name
  storage_account_type   = "Premium_LRS"
  create_option          = "Empty"
  disk_size_gb           = each.value["size"]
  tier                   = each.value["tier"]
  zones                  = [each.value["zone"]]
  disk_encryption_set_id = data.azurerm_disk_encryption_set.encset.id
}

resource "azurerm_virtual_machine_data_disk_attachment" "oracle_data" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  for_each           = { for i in range(length(local.datadisk_lun_map)) : local.datadisk_lun_map[i].datadisk_name => i }
  managed_disk_id    = azurerm_managed_disk.oracle_data[each.value].id
  virtual_machine_id = local.datadisk_lun_map[each.value].vmid
  lun                = local.datadisk_lun_map[each.value].lun
  caching            = "None"
}

##──── -- ────────────────────────────────────────────────────────────────────────────────
##──── -- ────────────────────────────────────────────────────────────────────────────────
