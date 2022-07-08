##========================================================================================
##                                                                                      ##
## APP SERVICE VARS                                                                     ##
##                                                                                      ##
##========================================================================================

locals {
  tz                                      = "Europe/Rome"
  java_opts                               = var.java_opts
  lang                                    = var.system_encoding
  saml_idp_spidregistry_metadata_url      = "/home/site/appconfig/spid-entities-idps_local.xml"
  saml_keystore_location                  = "file:/home/site/appconfig/saml_spid_sit.jks"
  saml_metadata_sp_filepath               = "/home/site/appconfig/sp_metadata.xml"
  saml_sp_metadata                        = "/home/site/appconfig/sp_metadata.xml"
  spring_profiles_active                  = var.spring_profile
  hostname_pm                             = var.hostname
  hostname_rtd                            = var.hostname_rtd
  static_hostname                         = var.static_hostname
  apim_context_root                       = var.apim_context_root
  nodo_spc_hostname                       = var.nodo_spc_hostname
  cittadinanza_hostname                   = var.cittadinanza_hostname
  jiffy_hostname                          = var.jiffy_hostname
  logging_white_list                      = var.logging_white_list
  bancomat_keystore_location              = var.bancomat_keystore_location
  bancomat_keystore_password              = data.azurerm_key_vault_secret.bancomat-keystore-password.value
  cors_allowed_origins                    = var.cors_allowed_origins
  hsm_activation_flag                     = true
  log_interceptor_pattern                 = data.azurerm_key_vault_secret.log-interceptor-pattern.value
  secret_key_store_path                   = var.secret_key_store_path
  crypto_private_server_key_path          = var.crypto_private_server_key_path
  crypto_public_server_key_path           = var.crypto_public_server_key_path
  com_sun_mamangement_jmxremote_ssl       = false
  jvm_route                               = var.jvm_route
  bancomatPay_client_group_code           = var.bancomatPay_client_group_code
  bancomatPay_client_institute_code       = var.bancomatPay_client_institute_code
  bancomatPay_client_tag                  = var.bancomatPay_client_tag
  bancomatPay_client_token                = var.bancomatPay_client_token
  bancomatPay_client_url                  = var.bancomatPay_client_url
  bancomatPay_client_timeout_ms           = var.bancomatPay_client_timeout_ms
  bancomatpay_session_timeout_s           = var.bancomatpay_session_timeout_s
  base_path_payment_gateway               = var.base_path_payment_gateway
  azureAuth_client_postepay_enabled       = var.azureAuth_client_postepay_enabled
  azureAuth_client_postepay_url           = data.azurerm_key_vault_secret.azureAuth_client_postepay_url.value
  azureAuth_client_postepay_scope         = data.azurerm_key_vault_secret.azureAuth_client_postepay_scope.value
  azureAuth_client_postepay_client_id     = data.azurerm_key_vault_secret.azureAuth_client_postepay_client_id.value
  azureAuth_client_postepay_client_secret = data.azurerm_key_vault_secret.azureAuth_client_postepay_client_secret.value
  azureAuth_client_maxTotal               = var.azureAuth_client_maxTotal
  azureAuth_client_maxPerRoute            = var.azureAuth_client_maxPerRoute
  azureAuth_client_timeout_ms             = var.azureAuth_client_timeout_ms
  postepay_client_url                     = var.postepay_client_url
  postepay_client_timeout_ms              = var.postepay_client_timeout_ms
  postepay_notificationURL                = var.postepay_notificationURL
  postepay_clientId_APP_config            = var.postepay_clientId_APP_config
  postepay_clientId_WEB_config            = var.postepay_clientId_WEB_config
  postepay_pgs_response_urlredirect       = var.postepay_pgs_response_urlredirect
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

##──── # Oracle connection Event Registry # ─────────────────────────────────────────────
locals {
  db-event-registry-url-simple = data.azurerm_key_vault_secret.db-event-registry-url-simple.value
  db-event-registry-username   = data.azurerm_key_vault_secret.db-event-registry-username.value
  db-event-registry-password   = data.azurerm_key_vault_secret.db-event-registry-password.value
}

##──── # Oracle connection AGID # ────────────────────────────────────────────────────────
locals {
  db-agid-url-simple = data.azurerm_key_vault_secret.db-agid-url-simple.value
  db-agid-username   = data.azurerm_key_vault_secret.db-agid-username.value
  db-agid-password   = data.azurerm_key_vault_secret.db-agid-password.value
}

##──── # Oracle connection NODO # ────────────────────────────────────────────────────────
locals {
  db-re-nodo-url-simple = data.azurerm_key_vault_secret.db-re-nodo-url-simple.value
  db-re-nodo-username   = data.azurerm_key_vault_secret.db-re-nodo-username.value
  db-re-nodo-password   = data.azurerm_key_vault_secret.db-re-nodo-password.value
}

##──── # Oracle connection NODO STORICO # ────────────────────────────────────────────────
locals {
  db-re-nodo-storico-url-simple = data.azurerm_key_vault_secret.db-re-nodo-storico-url-simple.value
  db-re-nodo-storico-username   = data.azurerm_key_vault_secret.db-re-nodo-storico-username.value
  db-re-nodo-storico-password   = data.azurerm_key_vault_secret.db-re-nodo-storico-password.value
}

##──── # Oracle connection RTD # ─────────────────────────────────────────────────────────
locals {
  db-rtd-url-simple = data.azurerm_key_vault_secret.db-rtd-url-simple.value
  db-rtd-username   = data.azurerm_key_vault_secret.db-rtd-username.value
  db-rtd-password   = data.azurerm_key_vault_secret.db-rtd-password.value
}

##──── # Oracle connection PGS # ─────────────────────────────────────────────────────────
locals {
  db-pgs-url-simple = data.azurerm_key_vault_secret.db-pgs-url-simple.value
  db-pgs-username   = data.azurerm_key_vault_secret.db-pgs-username.value
  db-pgs-password   = data.azurerm_key_vault_secret.db-pgs-password.value
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

##========================================================================================
##                                                                                      ##
## App service app_configs                                                              ##
##                                                                                      ##
##========================================================================================

##──── General config ────────────────────────────────────────────────────────────────────
locals {
  app_settings = {
    TZ                                                    = local.tz
    JAVA_OPTS                                             = local.java_opts
    LANG                                                  = local.lang
    DB_EVENT_REGISTRY_URL_SIMPLE                          = local.db-event-registry-url-simple
    DB_EVENT_REGISTRY_USERNAME                            = local.db-event-registry-username
    DB_EVENT_REGISTRY_PASSWORD                            = local.db-event-registry-password
    DB_AGID_URL_SIMPLE                                    = local.db-agid-url-simple
    DB_AGID_USERNAME                                      = local.db-agid-username
    DB_AGID_PASSWORD                                      = local.db-agid-password
    DB_RE_NODO_URL_SIMPLE                                 = local.db-re-nodo-url-simple
    DB_RE_NODO_USERNAME                                   = local.db-re-nodo-username
    DB_RE_NODO_PASSWORD                                   = local.db-re-nodo-password
    DB_RE_NODO_STORICO_URL_SIMPLE                         = local.db-re-nodo-storico-url-simple
    DB_RE_NODO_STORICO_USERNAME                           = local.db-re-nodo-storico-username
    DB_RE_NODO_STORICO_PASSWORD                           = local.db-re-nodo-storico-password
    DB_RTD_URL_SIMPLE                                     = local.db-rtd-url-simple
    DB_RTD_USERNAME                                       = local.db-rtd-username
    DB_RTD_PASSWORD                                       = local.db-rtd-password
    DB_PGS_URL_SIMPLE                                     = local.db-pgs-url-simple
    DB_PGS_USERNAME                                       = local.db-pgs-username
    DB_PGS_PASSWORD                                       = local.db-pgs-password
    APPINSIGHTS_INSTRUMENTATIONKEY                        = local.appinsights_instrumentationkey
    APPINSIGHTS_PROFILERFEATURE_VERSION                   = local.appinsights_profilerfeature_version
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION                   = local.appinsights_snapshotfeature_version
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT             = local.applicationinsights_configuration_content
    APPLICATIONINSIGHTS_CONNECTION_STRING                 = local.applicationinsights_connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION            = local.applicationinsightsagent_extension_version
    DiagnosticServices_EXTENSION_VERSION                  = local.diagnosticservices_extension_version
    InstrumentationEngine_EXTENSION_VERSION               = local.instrumentationengine_extension_version
    SnapshotDebugger_EXTENSION_VERSION                    = local.snapshotdebugger_extension_version
    XDT_MicrosoftApplicationInsights_BaseExtensions       = local.xdt_microsoftapplicationinsights_baseextensions
    XDT_MicrosoftApplicationInsights_Mode                 = local.xdt_microsoftapplicationinsights_mode
    XDT_MicrosoftApplicationInsights_PreemptSdk           = local.xdt_microsoftapplicationinsights_preemptsdk
    SAML_SP_METADATA                                      = local.saml_sp_metadata
    saml_idp_spidRegistry_metadata_url                    = local.saml_idp_spidregistry_metadata_url
    saml_keystore_location                                = local.saml_keystore_location
    saml_metadata_sp_filepath                             = local.saml_metadata_sp_filepath
    spring_profiles_active                                = local.spring_profiles_active
    bancomat_keystore_location                            = local.bancomat_keystore_location
    bancomat_keystore_password                            = local.bancomat_keystore_password
    org_apache_coyote_http11_DEFAULT_CONNECTION_TIMEOUT   = local.coyote_default_connection_timeout
    org_apache_coyote_http11_DEFAULT_KEEP_ALIVE_TIMEOUT   = local.coyote_default_keep_alive_timeout
    com_sia_ppt_pcp_SecretKeyStore_SECRET_KEY_STORE_PATH  = local.secret_key_store_path
    com_sia_ppt_crypto_KeyManager_PRIVATE_SERVER_KEY_PATH = local.crypto_private_server_key_path
    com_sia_ppt_crypto_KeyManager_PUBLIC_SERVER_KEY_PATH  = local.crypto_public_server_key_path
    com_sun_mamangement_jmxremote_ssl                     = local.com_sun_mamangement_jmxremote_ssl
    HOSTNAME_PM                                           = local.hostname_pm
    HOSTNAME_RTD                                          = local.hostname_rtd
    STATIC_HOSTNAME                                       = local.static_hostname
    APIM_CONTEXT_ROOT                                     = local.apim_context_root
    NODO_SPC_HOSTNAME                                     = local.nodo_spc_hostname
    CITTADINANZA_HOSTNAME                                 = local.cittadinanza_hostname
    JIFFY_HOSTNAME                                        = local.jiffy_hostname
    LOGGING_WHITE_LIST                                    = local.logging_white_list
    CORS_ALLOWED_ORIGINS                                  = local.cors_allowed_origins
    HTTP_TIMEOUT                                          = local.http_timeout
    MAX_CONNECTION                                        = local.max_connection
    REQUEST_TIMEOUT                                       = local.request_timeout
    MAX_PER_ROUTE                                         = local.max_per_route
    MAX_CONNECTION_CD                                     = local.max_connection_cd
    REQUEST_TIMEOUT_CD                                    = local.request_timeout_cd
    MAX_PER_ROUTE_CD                                      = local.max_per_route_cd
    VPOS_TIMEOUT                                          = local.vpos_timeout
    BANCOMAT_TIMEOUT                                      = local.bancomat_timeout
    MAX_CONNECTION_BANCOMAT                               = local.max_connection_bancomat
    MAX_PER_ROUTE_BANCOMAT                                = local.max_per_route_bancomat
    COBADGE_TIMEOUT                                       = local.cobadge_timeout
    MAX_CONNECTION_COBADGE                                = local.max_connection_cobadge
    MAX_PER_ROUTE_COBADGE                                 = local.max_per_route_cobadge
    PM_API_KEY                                            = local.pm_api_key
    HSM_ACTIVATION_FLAG                                   = local.hsm_activation_flag
    LOG_INTERCEPTOR_PATTERN                               = local.log_interceptor_pattern
    JVM_ROUTE                                             = local.jvm_route
    BASE_PATH_PAYMENT_GATEWAY                             = local.base_path_payment_gateway
  }
}

##──── RTD config ────────────────────────────────────────────────────────────────────────
locals {
  app_settings_rtd = {
    TZ                                                    = local.tz
    JAVA_OPTS                                             = local.java_opts
    LANG                                                  = local.lang
    DB_EVENT_REGISTRY_URL_SIMPLE                          = local.db-event-registry-url-simple
    DB_EVENT_REGISTRY_USERNAME                            = local.db-event-registry-username
    DB_EVENT_REGISTRY_PASSWORD                            = local.db-event-registry-password
    DB_AGID_URL_SIMPLE                                    = local.db-agid-url-simple
    DB_AGID_USERNAME                                      = local.db-agid-username
    DB_AGID_PASSWORD                                      = local.db-agid-password
    DB_RE_NODO_URL_SIMPLE                                 = local.db-re-nodo-url-simple
    DB_RE_NODO_USERNAME                                   = local.db-re-nodo-username
    DB_RE_NODO_PASSWORD                                   = local.db-re-nodo-password
    DB_RE_NODO_STORICO_URL_SIMPLE                         = local.db-re-nodo-storico-url-simple
    DB_RE_NODO_STORICO_USERNAME                           = local.db-re-nodo-storico-username
    DB_RE_NODO_STORICO_PASSWORD                           = local.db-re-nodo-storico-password
    DB_RTD_URL_SIMPLE                                     = local.db-rtd-url-simple
    DB_RTD_USERNAME                                       = local.db-rtd-username
    DB_RTD_PASSWORD                                       = local.db-rtd-password
    DB_PGS_URL_SIMPLE                                     = local.db-pgs-url-simple
    DB_PGS_USERNAME                                       = local.db-pgs-username
    DB_PGS_PASSWORD                                       = local.db-pgs-password
    APPINSIGHTS_INSTRUMENTATIONKEY                        = local.appinsights_instrumentationkey
    APPINSIGHTS_PROFILERFEATURE_VERSION                   = local.appinsights_profilerfeature_version
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION                   = local.appinsights_snapshotfeature_version
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT             = local.applicationinsights_configuration_content
    APPLICATIONINSIGHTS_CONNECTION_STRING                 = local.applicationinsights_connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION            = local.applicationinsightsagent_extension_version
    DiagnosticServices_EXTENSION_VERSION                  = local.diagnosticservices_extension_version
    InstrumentationEngine_EXTENSION_VERSION               = local.instrumentationengine_extension_version
    SnapshotDebugger_EXTENSION_VERSION                    = local.snapshotdebugger_extension_version
    XDT_MicrosoftApplicationInsights_BaseExtensions       = local.xdt_microsoftapplicationinsights_baseextensions
    XDT_MicrosoftApplicationInsights_Mode                 = local.xdt_microsoftapplicationinsights_mode
    XDT_MicrosoftApplicationInsights_PreemptSdk           = local.xdt_microsoftapplicationinsights_preemptsdk
    SAML_SP_METADATA                                      = local.saml_sp_metadata
    saml_idp_spidRegistry_metadata_url                    = local.saml_idp_spidregistry_metadata_url
    saml_keystore_location                                = local.saml_keystore_location
    saml_metadata_sp_filepath                             = local.saml_metadata_sp_filepath
    spring_profiles_active                                = local.spring_profiles_active
    bancomat_keystore_location                            = local.bancomat_keystore_location
    bancomat_keystore_password                            = local.bancomat_keystore_password
    org_apache_coyote_http11_DEFAULT_CONNECTION_TIMEOUT   = local.coyote_default_connection_timeout
    org_apache_coyote_http11_DEFAULT_KEEP_ALIVE_TIMEOUT   = local.coyote_default_keep_alive_timeout
    com_sia_ppt_pcp_SecretKeyStore_SECRET_KEY_STORE_PATH  = local.secret_key_store_path
    com_sia_ppt_crypto_KeyManager_PRIVATE_SERVER_KEY_PATH = local.crypto_private_server_key_path
    com_sia_ppt_crypto_KeyManager_PUBLIC_SERVER_KEY_PATH  = local.crypto_public_server_key_path
    com_sun_mamangement_jmxremote_ssl                     = local.com_sun_mamangement_jmxremote_ssl
    HOSTNAME_PM                                           = local.hostname_pm
    HOSTNAME_RTD                                          = local.hostname_rtd
    STATIC_HOSTNAME                                       = local.static_hostname
    APIM_CONTEXT_ROOT                                     = local.apim_context_root
    NODO_SPC_HOSTNAME                                     = local.nodo_spc_hostname
    CITTADINANZA_HOSTNAME                                 = local.cittadinanza_hostname
    JIFFY_HOSTNAME                                        = local.jiffy_hostname
    LOGGING_WHITE_LIST                                    = local.logging_white_list
    CORS_ALLOWED_ORIGINS                                  = local.cors_allowed_origins
    HTTP_TIMEOUT                                          = local.http_timeout
    MAX_CONNECTION                                        = local.max_connection
    REQUEST_TIMEOUT                                       = local.request_timeout
    MAX_PER_ROUTE                                         = local.max_per_route
    MAX_CONNECTION_CD                                     = local.max_connection_cd
    REQUEST_TIMEOUT_CD                                    = local.request_timeout_cd
    MAX_PER_ROUTE_CD                                      = local.max_per_route_cd
    VPOS_TIMEOUT                                          = local.vpos_timeout
    BANCOMAT_TIMEOUT                                      = local.bancomat_timeout
    MAX_CONNECTION_BANCOMAT                               = local.max_connection_bancomat
    MAX_PER_ROUTE_BANCOMAT                                = local.max_per_route_bancomat
    COBADGE_TIMEOUT                                       = local.cobadge_timeout
    MAX_CONNECTION_COBADGE                                = local.max_connection_cobadge
    MAX_PER_ROUTE_COBADGE                                 = local.max_per_route_cobadge
    PM_API_KEY                                            = local.pm_api_key
    HSM_ACTIVATION_FLAG                                   = local.hsm_activation_flag
    LOG_INTERCEPTOR_PATTERN                               = local.log_interceptor_pattern
    JVM_ROUTE                                             = local.jvm_route
    BASE_PATH_PAYMENT_GATEWAY                             = local.base_path_payment_gateway
  }
}

##──── LOGGING config ────────────────────────────────────────────────────────────────────
locals {
  app_settings_logging = {
    TZ                                                    = local.tz
    JAVA_OPTS                                             = local.java_opts
    LANG                                                  = local.lang
    DB_EVENT_REGISTRY_URL_SIMPLE                          = local.db-event-registry-url-simple
    DB_EVENT_REGISTRY_USERNAME                            = local.db-event-registry-username
    DB_EVENT_REGISTRY_PASSWORD                            = local.db-event-registry-password
    DB_AGID_URL_SIMPLE                                    = local.db-agid-url-simple
    DB_AGID_USERNAME                                      = local.db-agid-username
    DB_AGID_PASSWORD                                      = local.db-agid-password
    DB_RE_NODO_URL_SIMPLE                                 = local.db-re-nodo-url-simple
    DB_RE_NODO_USERNAME                                   = local.db-re-nodo-username
    DB_RE_NODO_PASSWORD                                   = local.db-re-nodo-password
    DB_RE_NODO_STORICO_URL_SIMPLE                         = local.db-re-nodo-storico-url-simple
    DB_RE_NODO_STORICO_USERNAME                           = local.db-re-nodo-storico-username
    DB_RE_NODO_STORICO_PASSWORD                           = local.db-re-nodo-storico-password
    DB_RTD_URL_SIMPLE                                     = local.db-rtd-url-simple
    DB_RTD_USERNAME                                       = local.db-rtd-username
    DB_RTD_PASSWORD                                       = local.db-rtd-password
    DB_PGS_URL_SIMPLE                                     = local.db-pgs-url-simple
    DB_PGS_USERNAME                                       = local.db-pgs-username
    DB_PGS_PASSWORD                                       = local.db-pgs-password
    APPINSIGHTS_INSTRUMENTATIONKEY                        = local.appinsights_instrumentationkey
    APPINSIGHTS_PROFILERFEATURE_VERSION                   = local.appinsights_profilerfeature_version
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION                   = local.appinsights_snapshotfeature_version
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT             = local.applicationinsights_configuration_content
    APPLICATIONINSIGHTS_CONNECTION_STRING                 = local.applicationinsights_connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION            = local.applicationinsightsagent_extension_version
    DiagnosticServices_EXTENSION_VERSION                  = local.diagnosticservices_extension_version
    InstrumentationEngine_EXTENSION_VERSION               = local.instrumentationengine_extension_version
    SnapshotDebugger_EXTENSION_VERSION                    = local.snapshotdebugger_extension_version
    XDT_MicrosoftApplicationInsights_BaseExtensions       = local.xdt_microsoftapplicationinsights_baseextensions
    XDT_MicrosoftApplicationInsights_Mode                 = local.xdt_microsoftapplicationinsights_mode
    XDT_MicrosoftApplicationInsights_PreemptSdk           = local.xdt_microsoftapplicationinsights_preemptsdk
    SAML_SP_METADATA                                      = local.saml_sp_metadata
    saml_idp_spidRegistry_metadata_url                    = local.saml_idp_spidregistry_metadata_url
    saml_keystore_location                                = local.saml_keystore_location
    saml_metadata_sp_filepath                             = local.saml_metadata_sp_filepath
    spring_profiles_active                                = local.spring_profiles_active
    bancomat_keystore_location                            = local.bancomat_keystore_location
    bancomat_keystore_password                            = local.bancomat_keystore_password
    org_apache_coyote_http11_DEFAULT_CONNECTION_TIMEOUT   = local.coyote_default_connection_timeout
    org_apache_coyote_http11_DEFAULT_KEEP_ALIVE_TIMEOUT   = local.coyote_default_keep_alive_timeout
    com_sia_ppt_pcp_SecretKeyStore_SECRET_KEY_STORE_PATH  = local.secret_key_store_path
    com_sia_ppt_crypto_KeyManager_PRIVATE_SERVER_KEY_PATH = local.crypto_private_server_key_path
    com_sia_ppt_crypto_KeyManager_PUBLIC_SERVER_KEY_PATH  = local.crypto_public_server_key_path
    com_sun_mamangement_jmxremote_ssl                     = local.com_sun_mamangement_jmxremote_ssl
    HOSTNAME_PM                                           = local.hostname_pm
    HOSTNAME_RTD                                          = local.hostname_rtd
    STATIC_HOSTNAME                                       = local.static_hostname
    APIM_CONTEXT_ROOT                                     = local.apim_context_root
    NODO_SPC_HOSTNAME                                     = local.nodo_spc_hostname
    CITTADINANZA_HOSTNAME                                 = local.cittadinanza_hostname
    JIFFY_HOSTNAME                                        = local.jiffy_hostname
    LOGGING_WHITE_LIST                                    = local.logging_white_list
    CORS_ALLOWED_ORIGINS                                  = local.cors_allowed_origins
    HTTP_TIMEOUT                                          = local.http_timeout
    MAX_CONNECTION                                        = local.max_connection
    REQUEST_TIMEOUT                                       = local.request_timeout
    MAX_PER_ROUTE                                         = local.max_per_route
    MAX_CONNECTION_CD                                     = local.max_connection_cd
    REQUEST_TIMEOUT_CD                                    = local.request_timeout_cd
    MAX_PER_ROUTE_CD                                      = local.max_per_route_cd
    VPOS_TIMEOUT                                          = local.vpos_timeout
    BANCOMAT_TIMEOUT                                      = local.bancomat_timeout
    MAX_CONNECTION_BANCOMAT                               = local.max_connection_bancomat
    MAX_PER_ROUTE_BANCOMAT                                = local.max_per_route_bancomat
    COBADGE_TIMEOUT                                       = local.cobadge_timeout
    MAX_CONNECTION_COBADGE                                = local.max_connection_cobadge
    MAX_PER_ROUTE_COBADGE                                 = local.max_per_route_cobadge
    PM_API_KEY                                            = local.pm_api_key
    HSM_ACTIVATION_FLAG                                   = local.hsm_activation_flag
    LOG_INTERCEPTOR_PATTERN                               = local.log_interceptor_pattern
    JVM_ROUTE                                             = local.jvm_route
    BASE_PATH_PAYMENT_GATEWAY                             = local.base_path_payment_gateway
  }
}

##──── BATCH config ────────────────────────────────────────────────────────────────
locals {
  app_settings_batch = {
    TZ                                                    = local.tz
    JAVA_OPTS                                             = local.java_opts
    LANG                                                  = local.lang
    DB_EVENT_REGISTRY_URL_SIMPLE                          = local.db-event-registry-url-simple
    DB_EVENT_REGISTRY_USERNAME                            = local.db-event-registry-username
    DB_EVENT_REGISTRY_PASSWORD                            = local.db-event-registry-password
    DB_AGID_URL_SIMPLE                                    = local.db-agid-url-simple
    DB_AGID_USERNAME                                      = local.db-agid-username
    DB_AGID_PASSWORD                                      = local.db-agid-password
    DB_RE_NODO_URL_SIMPLE                                 = local.db-re-nodo-url-simple
    DB_RE_NODO_USERNAME                                   = local.db-re-nodo-username
    DB_RE_NODO_PASSWORD                                   = local.db-re-nodo-password
    DB_RE_NODO_STORICO_URL_SIMPLE                         = local.db-re-nodo-storico-url-simple
    DB_RE_NODO_STORICO_USERNAME                           = local.db-re-nodo-storico-username
    DB_RE_NODO_STORICO_PASSWORD                           = local.db-re-nodo-storico-password
    DB_RTD_URL_SIMPLE                                     = local.db-rtd-url-simple
    DB_RTD_USERNAME                                       = local.db-rtd-username
    DB_RTD_PASSWORD                                       = local.db-rtd-password
    DB_PGS_URL_SIMPLE                                     = local.db-pgs-url-simple
    DB_PGS_USERNAME                                       = local.db-pgs-username
    DB_PGS_PASSWORD                                       = local.db-pgs-password
    APPINSIGHTS_INSTRUMENTATIONKEY                        = local.appinsights_instrumentationkey
    APPINSIGHTS_PROFILERFEATURE_VERSION                   = local.appinsights_profilerfeature_version
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION                   = local.appinsights_snapshotfeature_version
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT             = local.applicationinsights_configuration_content
    APPLICATIONINSIGHTS_CONNECTION_STRING                 = local.applicationinsights_connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION            = local.applicationinsightsagent_extension_version
    DiagnosticServices_EXTENSION_VERSION                  = local.diagnosticservices_extension_version
    InstrumentationEngine_EXTENSION_VERSION               = local.instrumentationengine_extension_version
    SnapshotDebugger_EXTENSION_VERSION                    = local.snapshotdebugger_extension_version
    XDT_MicrosoftApplicationInsights_BaseExtensions       = local.xdt_microsoftapplicationinsights_baseextensions
    XDT_MicrosoftApplicationInsights_Mode                 = local.xdt_microsoftapplicationinsights_mode
    XDT_MicrosoftApplicationInsights_PreemptSdk           = local.xdt_microsoftapplicationinsights_preemptsdk
    SAML_SP_METADATA                                      = local.saml_sp_metadata
    saml_idp_spidRegistry_metadata_url                    = local.saml_idp_spidregistry_metadata_url
    saml_keystore_location                                = local.saml_keystore_location
    saml_metadata_sp_filepath                             = local.saml_metadata_sp_filepath
    spring_profiles_active                                = local.spring_profiles_active
    bancomat_keystore_location                            = local.bancomat_keystore_location
    bancomat_keystore_password                            = local.bancomat_keystore_password
    org_apache_coyote_http11_DEFAULT_CONNECTION_TIMEOUT   = local.coyote_default_connection_timeout
    org_apache_coyote_http11_DEFAULT_KEEP_ALIVE_TIMEOUT   = local.coyote_default_keep_alive_timeout
    com_sia_ppt_pcp_SecretKeyStore_SECRET_KEY_STORE_PATH  = local.secret_key_store_path
    com_sia_ppt_crypto_KeyManager_PRIVATE_SERVER_KEY_PATH = local.crypto_private_server_key_path
    com_sia_ppt_crypto_KeyManager_PUBLIC_SERVER_KEY_PATH  = local.crypto_public_server_key_path
    com_sun_mamangement_jmxremote_ssl                     = local.com_sun_mamangement_jmxremote_ssl
    HOSTNAME_PM                                           = local.hostname_pm
    HOSTNAME_RTD                                          = local.hostname_rtd
    STATIC_HOSTNAME                                       = local.static_hostname
    APIM_CONTEXT_ROOT                                     = local.apim_context_root
    NODO_SPC_HOSTNAME                                     = local.nodo_spc_hostname
    CITTADINANZA_HOSTNAME                                 = local.cittadinanza_hostname
    JIFFY_HOSTNAME                                        = local.jiffy_hostname
    LOGGING_WHITE_LIST                                    = local.logging_white_list
    CORS_ALLOWED_ORIGINS                                  = local.cors_allowed_origins
    HTTP_TIMEOUT                                          = local.http_timeout
    MAX_CONNECTION                                        = local.max_connection
    REQUEST_TIMEOUT                                       = local.request_timeout
    MAX_PER_ROUTE                                         = local.max_per_route
    MAX_CONNECTION_CD                                     = local.max_connection_cd
    REQUEST_TIMEOUT_CD                                    = local.request_timeout_cd
    MAX_PER_ROUTE_CD                                      = local.max_per_route_cd
    VPOS_TIMEOUT                                          = local.vpos_timeout
    BANCOMAT_TIMEOUT                                      = local.bancomat_timeout
    MAX_CONNECTION_BANCOMAT                               = local.max_connection_bancomat
    MAX_PER_ROUTE_BANCOMAT                                = local.max_per_route_bancomat
    COBADGE_TIMEOUT                                       = local.cobadge_timeout
    MAX_CONNECTION_COBADGE                                = local.max_connection_cobadge
    MAX_PER_ROUTE_COBADGE                                 = local.max_per_route_cobadge
    PM_API_KEY                                            = local.pm_api_key
    HSM_ACTIVATION_FLAG                                   = local.hsm_activation_flag
    LOG_INTERCEPTOR_PATTERN                               = local.log_interceptor_pattern
    JVM_ROUTE                                             = local.jvm_route
    BASE_PATH_PAYMENT_GATEWAY                             = local.base_path_payment_gateway
  }
}

##──── PAYMENT GATEWAY config ─────────────────────────────────────────────────────────────
locals {
  app_settings_payment_gateway = {
    TZ                                                    = local.tz
    JAVA_OPTS                                             = local.java_opts
    LANG                                                  = local.lang
    DB_EVENT_REGISTRY_URL_SIMPLE                          = local.db-event-registry-url-simple
    DB_EVENT_REGISTRY_USERNAME                            = local.db-event-registry-username
    DB_EVENT_REGISTRY_PASSWORD                            = local.db-event-registry-password
    DB_AGID_URL_SIMPLE                                    = local.db-agid-url-simple
    DB_AGID_USERNAME                                      = local.db-agid-username
    DB_AGID_PASSWORD                                      = local.db-agid-password
    DB_RE_NODO_URL_SIMPLE                                 = local.db-re-nodo-url-simple
    DB_RE_NODO_USERNAME                                   = local.db-re-nodo-username
    DB_RE_NODO_PASSWORD                                   = local.db-re-nodo-password
    DB_RE_NODO_STORICO_URL_SIMPLE                         = local.db-re-nodo-storico-url-simple
    DB_RE_NODO_STORICO_USERNAME                           = local.db-re-nodo-storico-username
    DB_RE_NODO_STORICO_PASSWORD                           = local.db-re-nodo-storico-password
    DB_RTD_URL_SIMPLE                                     = local.db-rtd-url-simple
    DB_RTD_USERNAME                                       = local.db-rtd-username
    DB_RTD_PASSWORD                                       = local.db-rtd-password
    DB_PGS_URL_SIMPLE                                     = local.db-pgs-url-simple
    DB_PGS_USERNAME                                       = local.db-pgs-username
    DB_PGS_PASSWORD                                       = local.db-pgs-password
    APPINSIGHTS_INSTRUMENTATIONKEY                        = local.appinsights_instrumentationkey
    APPINSIGHTS_PROFILERFEATURE_VERSION                   = local.appinsights_profilerfeature_version
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION                   = local.appinsights_snapshotfeature_version
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT             = local.applicationinsights_configuration_content
    APPLICATIONINSIGHTS_CONNECTION_STRING                 = local.applicationinsights_connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION            = local.applicationinsightsagent_extension_version
    DiagnosticServices_EXTENSION_VERSION                  = local.diagnosticservices_extension_version
    InstrumentationEngine_EXTENSION_VERSION               = local.instrumentationengine_extension_version
    SnapshotDebugger_EXTENSION_VERSION                    = local.snapshotdebugger_extension_version
    XDT_MicrosoftApplicationInsights_BaseExtensions       = local.xdt_microsoftapplicationinsights_baseextensions
    XDT_MicrosoftApplicationInsights_Mode                 = local.xdt_microsoftapplicationinsights_mode
    XDT_MicrosoftApplicationInsights_PreemptSdk           = local.xdt_microsoftapplicationinsights_preemptsdk
    SAML_SP_METADATA                                      = local.saml_sp_metadata
    saml_idp_spidRegistry_metadata_url                    = local.saml_idp_spidregistry_metadata_url
    saml_keystore_location                                = local.saml_keystore_location
    saml_metadata_sp_filepath                             = local.saml_metadata_sp_filepath
    spring_profiles_active                                = local.spring_profiles_active
    bancomat_keystore_location                            = local.bancomat_keystore_location
    bancomat_keystore_password                            = local.bancomat_keystore_password
    org_apache_coyote_http11_DEFAULT_CONNECTION_TIMEOUT   = local.coyote_default_connection_timeout
    org_apache_coyote_http11_DEFAULT_KEEP_ALIVE_TIMEOUT   = local.coyote_default_keep_alive_timeout
    com_sia_ppt_pcp_SecretKeyStore_SECRET_KEY_STORE_PATH  = local.secret_key_store_path
    com_sia_ppt_crypto_KeyManager_PRIVATE_SERVER_KEY_PATH = local.crypto_private_server_key_path
    com_sia_ppt_crypto_KeyManager_PUBLIC_SERVER_KEY_PATH  = local.crypto_public_server_key_path
    com_sun_mamangement_jmxremote_ssl                     = local.com_sun_mamangement_jmxremote_ssl
    HOSTNAME_PM                                           = local.hostname_pm
    HOSTNAME_RTD                                          = local.hostname_rtd
    STATIC_HOSTNAME                                       = local.static_hostname
    APIM_CONTEXT_ROOT                                     = local.apim_context_root
    NODO_SPC_HOSTNAME                                     = local.nodo_spc_hostname
    CITTADINANZA_HOSTNAME                                 = local.cittadinanza_hostname
    JIFFY_HOSTNAME                                        = local.jiffy_hostname
    LOGGING_WHITE_LIST                                    = local.logging_white_list
    CORS_ALLOWED_ORIGINS                                  = local.cors_allowed_origins
    HTTP_TIMEOUT                                          = local.http_timeout
    MAX_CONNECTION                                        = local.max_connection
    REQUEST_TIMEOUT                                       = local.request_timeout
    MAX_PER_ROUTE                                         = local.max_per_route
    MAX_CONNECTION_CD                                     = local.max_connection_cd
    REQUEST_TIMEOUT_CD                                    = local.request_timeout_cd
    MAX_PER_ROUTE_CD                                      = local.max_per_route_cd
    VPOS_TIMEOUT                                          = local.vpos_timeout
    BANCOMAT_TIMEOUT                                      = local.bancomat_timeout
    MAX_CONNECTION_BANCOMAT                               = local.max_connection_bancomat
    MAX_PER_ROUTE_BANCOMAT                                = local.max_per_route_bancomat
    COBADGE_TIMEOUT                                       = local.cobadge_timeout
    MAX_CONNECTION_COBADGE                                = local.max_connection_cobadge
    MAX_PER_ROUTE_COBADGE                                 = local.max_per_route_cobadge
    PM_API_KEY                                            = local.pm_api_key
    HSM_ACTIVATION_FLAG                                   = local.hsm_activation_flag
    LOG_INTERCEPTOR_PATTERN                               = local.log_interceptor_pattern
    JVM_ROUTE                                             = local.jvm_route
    BANCOMATPAY_CLIENT_GROUP_CODE                         = local.bancomatPay_client_group_code
    BANCOMATPAY_CLIENT_INSTITUTE_CODE                     = local.bancomatPay_client_institute_code
    BANCOMATPAY_CLIENT_TAG                                = local.bancomatPay_client_tag
    BANCOMATPAY_CLIENT_TOKEN                              = local.bancomatPay_client_token
    BANCOMATPAY_CLIENT_URL                                = local.bancomatPay_client_url
    BANCOMATPAY_CLIENT_TIMEOUT_MS                         = local.bancomatPay_client_timeout_ms
    BANCOMATPAY_SESSION_TIMEOUT_S                         = local.bancomatpay_session_timeout_s
    AZUREAUTH_CLIENT_POSTEPAY_ENABLED                     = local.azureAuth_client_postepay_enabled
    AZUREAUTH_CLIENT_POSTEPAY_URL                         = local.azureAuth_client_postepay_url
    AZUREAUTH_CLIENT_POSTEPAY_SCOPE                       = local.azureAuth_client_postepay_scope
    AZUREAUTH_CLIENT_POSTEPAY_CLIENT_ID                   = local.azureAuth_client_postepay_client_id
    AZUREAUTH_CLIENT_POSTEPAY_CLIENT_SECRET               = local.azureAuth_client_postepay_client_secret
    AZUREAUTH_CLIENT_MAXTOTAL                             = local.azureAuth_client_maxTotal
    AZUREAUTH_CLIENT_MAXPERROUTE                          = local.azureAuth_client_maxPerRoute
    AZUREAUTH_CLIENT_TIMEOUT_MS                           = local.azureAuth_client_timeout_ms
    POSTEPAY_CLIENT_URL                                   = local.postepay_client_url
    POSTEPAY_CLIENT_TIMEOUT_MS                            = local.postepay_client_timeout_ms
    POSTEPAY_NOTIFICATIONURL                              = local.postepay_notificationURL
    POSTEPAY_CLIENTID_APP_CONFIG                          = local.postepay_clientId_APP_config
    POSTEPAY_CLIENTID_WEB_CONFIG                          = local.postepay_clientId_WEB_config
    POSTEPAY_PGS_RESPONSE_URLREDIRECT                     = local.postepay_pgs_response_urlredirect
  }
}

##──── *** ───────────────────────────────────────────────────────────────────────────────
##──── *** ───────────────────────────────────────────────────────────────────────────────
