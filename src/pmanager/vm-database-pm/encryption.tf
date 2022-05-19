data "azurerm_disk_encryption_set" "encset" {
  name                = var.encset_name
  resource_group_name = var.encset_rg
}
