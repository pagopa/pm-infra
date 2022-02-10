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
  cors_allowed_origins               = var.cors_allowed_origins
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
