data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault
  resource_group_name = var.key_vault_rg
}

##──── Inbound network address space ─────────────────────────────────────────────────────
data "azurerm_key_vault_secret" "vnet-inbound-address-space" {
  name         = format("%s-%s-pci", "vnet-inbound-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##──── Outgoing network address space ─────────────────────────────────────────────────────
data "azurerm_key_vault_secret" "vnet-outgoing-address-space" {
  name         = format("%s-%s-pci", "vnet-outgoing-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##──── Database network address space ─────────────────────────────────────────────────────
data "azurerm_key_vault_secret" "vnet-database-address-space" {
  name         = format("%s-%s-pci", "vnet-database-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}