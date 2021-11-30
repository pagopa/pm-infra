data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault
  resource_group_name = var.key_vault_rg
}

##──── Postgress keys ────────────────────────────────────────────────────────────────────

data "azurerm_key_vault_secret" "postgres-connection-url" {
  name         = format("%s-%s", "postgres-connection-url", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "postgres-server-admin" {
  name         = format("%s-%s", "postgres-server-admin", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "postgres-server-password" {
  name         = format("%s-%s", "postgres-server-password", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}


##──── App service keys ──────────────────────────────────────────────────────────────────

data "azurerm_key_vault_secret" "address-space" {
  name         = format("%s-%s", "address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "outgoing-subnet-address-space" {
  name         = format("%s-%s", "outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "endpointsubnet-address-space" {
  name         = format("%s-%s", "endpointsubnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "ip-restrictions-pda" {
  name         = format("%s-%s", "ip-restrictions-pda", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
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


##──── Vm keys ───────────────────────────────────────────────────────────────────────────

data "azurerm_key_vault_secret" "vm-address-space" {
  name         = format("%s-%s", "vm-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "vm-address-prefix" {
  name         = format("%s-%s", "vm-address-prefix", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "admin-user" {
  name         = format("%s-%s", "admin-user", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "admin-password" {
  name         = format("%s-%s", "admin-password", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}