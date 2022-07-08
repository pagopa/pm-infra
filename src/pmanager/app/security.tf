data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault
  resource_group_name = var.key_vault_rg
}

##========================================================================================
##                                                                                      ##
## Oracle databases secrets                                                             ##
##                                                                                      ##
##========================================================================================

##──── # Oracle connection Event Registry # ─────────────────────────────────────────────
data "azurerm_key_vault_secret" "db-event-registry-url-simple" {
  name         = format("%s-%s", var.environment, "db-event-registry-url-simple")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-event-registry-username" {
  name         = format("%s-%s", var.environment, "db-event-registry-username")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-event-registry-password" {
  name         = format("%s-%s", var.environment, "db-event-registry-password")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##──── # Oracle connection AGID # ────────────────────────────────────────────────────────
data "azurerm_key_vault_secret" "db-agid-url-simple" {
  name         = format("%s-%s", var.environment, "db-agid-url-simple")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-agid-username" {
  name         = format("%s-%s", var.environment, "db-agid-username")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-agid-password" {
  name         = format("%s-%s", var.environment, "db-agid-password")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##──── # Oracle connection NODO # ────────────────────────────────────────────────────────
data "azurerm_key_vault_secret" "db-re-nodo-url-simple" {
  name         = format("%s-%s", var.environment, "db-re-nodo-url-simple")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-re-nodo-username" {
  name         = format("%s-%s", var.environment, "db-re-nodo-username")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-re-nodo-password" {
  name         = format("%s-%s", var.environment, "db-re-nodo-password")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##──── # Oracle connection NODO STORICO # ────────────────────────────────────────────────
data "azurerm_key_vault_secret" "db-re-nodo-storico-url-simple" {
  name         = format("%s-%s", var.environment, "db-re-nodo-storico-url-simple")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-re-nodo-storico-username" {
  name         = format("%s-%s", var.environment, "db-re-nodo-storico-username")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-re-nodo-storico-password" {
  name         = format("%s-%s", var.environment, "db-re-nodo-storico-password")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##──── # Oracle connection RTD # ─────────────────────────────────────────────────────────
data "azurerm_key_vault_secret" "db-rtd-url-simple" {
  name         = format("%s-%s", var.environment, "db-rtd-url-simple")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-rtd-username" {
  name         = format("%s-%s", var.environment, "db-rtd-username")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-rtd-password" {
  name         = format("%s-%s", var.environment, "db-rtd-password")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##──── # Oracle connection PGS # ─────────────────────────────────────────────────────────
data "azurerm_key_vault_secret" "db-pgs-url-simple" {
  name         = format("%s-%s", var.environment, "db-pgs-url-simple")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-pgs-username" {
  name         = format("%s-%s", var.environment, "db-pgs-username")
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
data "azurerm_key_vault_secret" "db-pgs-password" {
  name         = format("%s-%s", var.environment, "db-pgs-password")
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

data "azurerm_key_vault_secret" "unique-outgoing-subnet-address-space" {
  name         = format("%s-%s", "unique-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

# data "azurerm_key_vault_secret" "admin-panel-outgoing-subnet-address-space" {
#   name         = format("%s-%s", "admin-panel-outgoing-subnet-address-space", var.environment)
#   key_vault_id = data.azurerm_key_vault.keyvault.id
# }

data "azurerm_key_vault_secret" "wisp-outgoing-subnet-address-space" {
  name         = format("%s-%s", "wisp-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

# data "azurerm_key_vault_secret" "rtd-outgoing-subnet-address-space" {
#   name         = format("%s-%s", "rtd-outgoing-subnet-address-space", var.environment)
#   key_vault_id = data.azurerm_key_vault.keyvault.id
# }

# data "azurerm_key_vault_secret" "logging-outgoing-subnet-address-space" {
#   name         = format("%s-%s", "logging-outgoing-subnet-address-space", var.environment)
#   key_vault_id = data.azurerm_key_vault.keyvault.id
# }

# data "azurerm_key_vault_secret" "batch-outgoing-subnet-address-space" {
#   name         = format("%s-%s", "batch-outgoing-subnet-address-space", var.environment)
#   key_vault_id = data.azurerm_key_vault.keyvault.id
# }

data "azurerm_key_vault_secret" "restapi-outgoing-subnet-address-space" {
  name         = format("%s-%s", "restapi-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "restapi-io-outgoing-subnet-address-space" {
  name         = format("%s-%s", "restapi-io-outgoing-subnet-address-space", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

# data "azurerm_key_vault_secret" "payment-gateway-outgoing-subnet-address-space" {
#   name         = format("%s-%s", "payment-gateway-outgoing-subnet-address-space", var.environment)
#   key_vault_id = data.azurerm_key_vault.keyvault.id
# }

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

data "azurerm_key_vault_secret" "s4s-address" {
  name         = format("%s-%s", "s4s-address", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "azureAuth_client_postepay_url" {
  name         = format("%s-%s", "azureAuth-client-postepay-url", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "azureAuth_client_postepay_scope" {
  name         = format("%s-%s", "azureAuth-client-postepay-scope", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "azureAuth_client_postepay_client_id" {
  name         = format("%s-%s", "azureAuth-client-postepay-client-id", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "azureAuth_client_postepay_client_secret" {
  name         = format("%s-%s", "azureAuth-client-postepay-client-secret", var.environment)
  key_vault_id = data.azurerm_key_vault.keyvault.id
}




