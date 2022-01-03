data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault
  resource_group_name = var.key_vault_rg
}

##──── Oracle databases keys ─────────────────────────────────────────────────────────────

data "azurerm_key_vault_secret" "oracle-connection-url" {
  name         = format("%s-%s", "oracle-connection-url", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "oracle-server-agid-user" {
  name         = format("%s-%s", "oracle-server-agid-user", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "oracle-server-agid-user-password" {
  name         = format("%s-%s", "oracle-server-agid-user-password", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}


##──── App service keys ──────────────────────────────────────────────────────────────────

data "azurerm_key_vault_secret" "admin-panel-outgoing-subnet-address-space" {
  name         = format("%s-%s", "admin-panel-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "wisp-outgoing-subnet-address-space" {
  name         = format("%s-%s", "wisp-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "rtd-outgoing-subnet-address-space" {
  name         = format("%s-%s", "rtd-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "logging-outgoing-subnet-address-space" {
  name         = format("%s-%s", "logging-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "batch-outgoing-subnet-address-space" {
  name         = format("%s-%s", "batch-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "restapi-outgoing-subnet-address-space" {
  name         = format("%s-%s", "restapi-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "restapi-io-outgoing-subnet-address-space" {
  name         = format("%s-%s", "restapi-io-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

#data "azurerm_key_vault_secret" "inbound-subnet-address-space" {
#  name         = format("%s-%s", "inbound-subnet-address-space", var.environment)
#  key_vault_id = data.azurerm_key_vault.keyvault.id
#}
