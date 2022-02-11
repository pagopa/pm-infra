##========================================================================================
##                                                                                      ##
## APP SERVICE VARS                                                                     ##
##                                                                                      ##
##========================================================================================

locals {
  java_opts                          = var.java_opts
  lang                               = var.system_encoding
  saml_idp_spidregistry_metadata_url = "/home/site/appconfig/spid-entities-idps_local.xml"
  saml_keystore_location             = "file:/home/site/appconfig/saml_spid_sit.jks"
  saml_metadata_sp_filepath          = "/home/site/appconfig/sp_metadata.xml"
  saml_sp_metadata                   = "/home/site/appconfig/sp_metadata.xml"
  spring_profiles_active             = var.spring_profile
  hostname_pm                        = var.hostname
  hostname_rtd                       = var.hostname_rtd
  static_hostname                    = var.static_hostname
  nodo_spc_hostname                  = var.nodo_spc_hostname
  cittadinanza_hostname              = var.cittadinanza_hostname
  jiffy_hostname                     = var.jiffy_hostname
  logging_white_list                 = var.logging_white_list
  bancomat_keystore_location         = var.bancomat_keystore_location
  bancomat_keystore_password         = data.azurerm_key_vault_secret.bancomat-keystore-password.value
  cors_allowed_origins               = var.cors_allowed_origins
  hsm_activation_flag                = true
  log_interceptor_pattern            = data.azurerm_key_vault_secret.log-interceptor-pattern.value
  secret_key_store_path              = var.secret_key_store_path
  crypto_private_server_key_path     = var.crypto_private_server_key_path
  crypto_public_server_key_path      = var.crypto_public_server_key_path
  com_sun_mamangement_jmxremote_ssl  = false
  jvm_route                          = var.jvm_route
}

##──── connection parameters ─────────────────────────────────────────────────────────────
locals {
  http_timeout                      = 15000
  max_connection                    = 400
  request_timeout                   = 20000
  max_per_route                     = 50
  max_connection_cd                 = 1024
  request_timeout_cd                = 2000
  max_per_route_cd                  = 1024
  vpos_timeout                      = 10000
  bancomat_timeout                  = 10000
  max_connection_bancomat           = 1000
  max_per_route_bancomat            = 1000
  cobadge_timeout                   = 10000
  max_connection_cobadge            = 1000
  max_per_route_cobadge             = 1000
  coyote_default_connection_timeout = 30000
  coyote_default_keep_alive_timeout = 6000
}

##──── PM api key ────────────────────────────────────────────────────────────────────────
locals {
  pm_api_key = data.azurerm_key_vault_secret.pm-api-key.value
}

##──── *** ───────────────────────────────────────────────────────────────────────────────
##──── *** ───────────────────────────────────────────────────────────────────────────────

##========================================================================================
##                                                                                      ##
## DATABASE VARIABLE                                                                    ##
##                                                                                      ##
##========================================================================================
##──── # Oracle connection PP # ──────────────────────────────────────────────────────────
locals {
  pp_oracle_connection_url         = data.azurerm_key_vault_secret.oracle-connection-url.value
  pp_oracle_server_admin_full_name = data.azurerm_key_vault_secret.oracle-server-agid-user.value
  pp_oracle_server_admin_password  = data.azurerm_key_vault_secret.oracle-server-agid-user-password.value
}

##──── # Oracle connection RTD # ─────────────────────────────────────────────────────────
locals {
  rtd_oracle_connection_url         = data.azurerm_key_vault_secret.oracle-connection-url.value
  rtd_oracle_server_admin_full_name = data.azurerm_key_vault_secret.oracle-server-rtd-user.value
  rtd_oracle_server_admin_password  = data.azurerm_key_vault_secret.oracle-server-rtd-user-password.value
}

##──── # Oracle connection Evente Registry # ─────────────────────────────────────────────
locals {
  event_reg_oracle_connection_url         = data.azurerm_key_vault_secret.oracle-connection-url.value
  event_reg_oracle_server_admin_full_name = data.azurerm_key_vault_secret.oracle-server-event-reg-user.value
  event_reg_oracle_server_admin_password  = data.azurerm_key_vault_secret.oracle-server-event-reg-user-password.value
}

##──── *** ───────────────────────────────────────────────────────────────────────────────
##──── *** ───────────────────────────────────────────────────────────────────────────────

##========================================================================================
##                                                                                      ##
## APPINSIGHT VARIABLE                                                                  ##
##                                                                                      ##
##========================================================================================

locals {
  appinsights_instrumentationkey                  = var.appinsight_name != "" ? data.azurerm_application_insights.appinsight[0].instrumentation_key : var.appinsight_instrumentation_key
  appinsights_profilerfeature_version             = "1.0.0"
  appinsights_snapshotfeature_version             = "1.0.0"
  applicationinsights_configuration_content       = ""
  applicationinsights_connection_string           = var.appinsight_name != "" ? data.azurerm_application_insights.appinsight[0].instrumentation_key : var.appinsight_connection_string
  applicationinsightsagent_extension_version      = "~3"
  diagnosticservices_extension_version            = "~3"
  instrumentationengine_extension_version         = "disabled"
  snapshotdebugger_extension_version              = "disabled"
  xdt_microsoftapplicationinsights_baseextensions = "disabled"
  xdt_microsoftapplicationinsights_mode           = "recommended"
  xdt_microsoftapplicationinsights_preemptsdk     = "disabled"
}

##──── *** ───────────────────────────────────────────────────────────────────────────────
##──── *** ───────────────────────────────────────────────────────────────────────────────
