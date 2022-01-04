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
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7.6"
    version   = "latest"
  }
}

resource "azurerm_managed_disk" "oracle_vgdb_sit" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count                = var.vm_count
  name                 = "oracle_vgdb_sit"
  location             = data.azurerm_resource_group.vmrg.location
  resource_group_name  = data.azurerm_resource_group.vmrg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 200
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk1" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count              = var.vm_count
  managed_disk_id    = azurerm_managed_disk.oracle_vgdb_sit[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[count.index].id
  lun                = "0"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "oracle_data_sit" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count                = var.vm_count
  name                 = "oracle_data_sit"
  location             = data.azurerm_resource_group.vmrg.location
  resource_group_name  = data.azurerm_resource_group.vmrg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 100
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk2" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count              = var.vm_count
  managed_disk_id    = azurerm_managed_disk.oracle_data_sit[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[count.index].id
  lun                = "1"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "oracle_reco_sit" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count                = var.vm_count
  name                 = "oracle_reco_sit"
  location             = data.azurerm_resource_group.vmrg.location
  resource_group_name  = data.azurerm_resource_group.vmrg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 30
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk3" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count              = var.vm_count
  managed_disk_id    = azurerm_managed_disk.oracle_reco_sit[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[count.index].id
  lun                = "2"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "oracle_has_sit" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count                = var.vm_count
  name                 = "oracle_has_sit"
  location             = data.azurerm_resource_group.vmrg.location
  resource_group_name  = data.azurerm_resource_group.vmrg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 20
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk4" {
  depends_on         = [azurerm_linux_virtual_machine.vm]
  count              = var.vm_count
  managed_disk_id    = azurerm_managed_disk.oracle_has_sit[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[count.index].id
  lun                = "3"
  caching            = "ReadWrite"
}
