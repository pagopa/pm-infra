data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault
  resource_group_name = var.key_vault_rg
}

##──── Application gateway keys ──────────────────────────────────────────────────────────

data "azurerm_key_vault_secret" "appgw-subnet-address-space" {
  name         = format("%s-%s", "appgw-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "appgw-private-ip-address" {
  name         = format("%s-%s", "appgw-private-ip-address", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "apim-public-ip" {
  name         = format("%s-%s", "apim-public-ip", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}