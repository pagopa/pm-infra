data "azurerm_resource_group" "vmrg" {
  name     = var.vmrg
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
  name                            = var.vm_name
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