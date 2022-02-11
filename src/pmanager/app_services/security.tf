data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault
  resource_group_name = var.key_vault_rg
}

##──── Oracle databases keys ─────────────────────────────────────────────────────────────

data "azurerm_key_vault_secret" "oracle-connection-url" {
  name         = format("%s-%s", "oracle-connection-url", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

# PP credential
data "azurerm_key_vault_secret" "oracle-server-agid-user" {
  name         = format("%s-%s", "oracle-server-agid-user", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "oracle-server-agid-user-password" {
  name         = format("%s-%s", "oracle-server-agid-user-password", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

# RTD credential
data "azurerm_key_vault_secret" "oracle-server-rtd-user" {
  name         = format("%s-%s", "oracle-server-rtd-user", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "oracle-server-rtd-user-password" {
  name         = format("%s-%s", "oracle-server-rtd-user-password", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

# EVENT REGISTRY credential
data "azurerm_key_vault_secret" "oracle-server-event-reg-user" {
  name         = format("%s-%s", "oracle-server-event-reg-user", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "oracle-server-event-reg-user-password" {
  name         = format("%s-%s", "oracle-server-event-reg-user-password", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##──── PM api key ────────────────────────────────────────────────────────────────────────
data "azurerm_key_vault_secret" "pm-api-key" {
  name         = format("%s-%s", "pm-api-key", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##──── logging interception ──────────────────────────────────────────────────────────────
data "azurerm_key_vault_secret" "log-interceptor-pattern" {
  name         = format("%s-%s", "log-interceptor-pattern", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##──── bancomat keystore password ────────────────────────────────────────────────────────
data "azurerm_key_vault_secret" "bancomat-keystore-password" {
  name         = format("%s-%s", "bancomat-keystore-password", var.environment)
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
