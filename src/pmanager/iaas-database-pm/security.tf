data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault
  resource_group_name = var.key_vault_rg
}

##──── Vm keys ───────────────────────────────────────────────────────────────────────────

# data "azurerm_key_vault_secret" "vm-address-space" {
#   name         = format("%s-%s", var.prefix, "vm-address-space")
#   key_vault_id = data.azurerm_key_vault.keyvault.id
# }

# data "azurerm_key_vault_secret" "vm-address-prefix" {
#   name         = format("%s-%s", var.prefix, "vm-address-prefix")
#   key_vault_id = data.azurerm_key_vault.keyvault.id
# }

data "azurerm_key_vault_secret" "admin-user" {
  name         = format("%s-%s", "admin-user", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "admin-password" {
  name         = format("%s-%s", "admin-password", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
