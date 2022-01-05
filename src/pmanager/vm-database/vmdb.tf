data "azurerm_resource_group" "vmrg" {
  name     = var.vmrg
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
  name                = format("%s-%s", var.vm_nic, var.environment)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                           = var.vm_count
  name                            = format("%s0%s", var.vm_name, count.index+1)
  resource_group_name             = data.azurerm_resource_group.vmrg.name
  location                        = data.azurerm_resource_group.vmrg.location
  size                            = var.vm_size
  admin_username                  = data.azurerm_key_vault_secret.admin-user.value
  admin_password                  = data.azurerm_key_vault_secret.admin-password.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7.6"
    version   = "latest"
  }
}

resource "azurerm_managed_disk" "oracle_vgdb" {
  depends_on           = [azurerm_linux_virtual_machine.vm]
  count                = var.vm_count
  name                 = format("oracle-vgdb-%s-%s", azurerm_linux_virtual_machine.vm[count.index].name, var.environment)
  location             = data.azurerm_resource_group.vmrg.location
  resource_group_name  = data.azurerm_resource_group.vmrg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_oracle_vgdb_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk1" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count              = var.vm_count
  managed_disk_id    = azurerm_managed_disk.oracle_vgdb[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[count.index].id
  lun                = "0"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "oracle_data" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count                = var.vm_count
  name                 = format("oracle-data-%s-%s", azurerm_linux_virtual_machine.vm[count.index].name, var.environment)
  location             = data.azurerm_resource_group.vmrg.location
  resource_group_name  = data.azurerm_resource_group.vmrg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_oracle_data_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk2" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count              = var.vm_count
  managed_disk_id    = azurerm_managed_disk.oracle_data[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[count.index].id
  lun                = "1"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "oracle_reco" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count                = var.vm_count
  name                 = format("oracle-reco-%s-%s", azurerm_linux_virtual_machine.vm[count.index].name, var.environment)
  location             = data.azurerm_resource_group.vmrg.location
  resource_group_name  = data.azurerm_resource_group.vmrg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_oracle_reco_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk3" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count              = var.vm_count
  managed_disk_id    = azurerm_managed_disk.oracle_reco[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[count.index].id
  lun                = "2"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "oracle_has" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count                = var.vm_count
  name                 = format("oracle-has-%s-%s", azurerm_linux_virtual_machine.vm[count.index].name, var.environment)
  location             = data.azurerm_resource_group.vmrg.location
  resource_group_name  = data.azurerm_resource_group.vmrg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_oracle_has_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk4" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count              = var.vm_count
  managed_disk_id    = azurerm_managed_disk.oracle_has[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[count.index].id
  lun                = "3"
  caching            = "ReadWrite"
}

