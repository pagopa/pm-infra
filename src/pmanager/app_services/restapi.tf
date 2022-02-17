module "restapi" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=app-service-storage-mounts"

  name = format("%s-%s", var.restapi_name, var.environment)

  ftps_state = "AllAllowed"

  plan_name     = format("%s-%s-%s", var.restapi_name, var.plan_name, var.environment)
  plan_type     = "internal"
  plan_sku_size = var.plan_sku
  plan_sku_tier = var.plan_sku_tier
  plan_kind     = var.plan_kind
  plan_reserved = var.plan_reserved
  always_on     = "true"

  resource_group_name = data.azurerm_resource_group.rg.name

  # Linux App Framework and version for the App Service.
  linux_fx_version = "${var.runtime_name}|${var.runtime_version}"

  # Disable enforcing https connection
  https_only = false

  app_settings = {
    APPCONFIG_PATH                                        = format("/storage/appconfig/%s", var.restapi_name)
    TOOLS_PATH                                            = format("/storage/tools/%s", var.restapi_name)
    JAVA_OPTS                                             = local.java_opts
    LANG                                                  = local.lang
    ORACLE_CONNECTION_URL                                 = local.pp_oracle_connection_url
    ORACLE_SERVER_ADMIN_FULL_NAME                         = local.pp_oracle_server_admin_full_name
    ORACLE_SERVER_ADMIN_PASSWORD                          = local.pp_oracle_server_admin_password
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
  }

  app_command_line = "/home/site/deployments/tools/startup_script.sh"

  # storage_mounts = [{
  #   name         = "appconfig"
  #   type         = "AzureFiles"
  #   account_name = azurerm_storage_account.storage.name
  #   share_name   = "pm-appconfig"
  #   access_key   = azurerm_storage_account.storage.primary_access_key
  #   mount_path   = "/storage/appconfig"
  #   },
  #   {
  #     name         = "tools"
  #     type         = "AzureFiles"
  #     account_name = azurerm_storage_account.storage.name
  #     share_name   = "pm-tools"
  #     access_key   = azurerm_storage_account.storage.primary_access_key
  #     mount_path   = "/storage/tools"
  #   }
  # ]

  tags = {
    kind        = "app service",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_subnet" "restapi" {
  name                 = format("pm-restapi-subnet-%s", var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_outgoing.name
  address_prefixes     = [data.azurerm_key_vault_secret.restapi-outgoing-subnet-address-space.value]
  delegation {
    name = "Microsoft.Web.serverFarms"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action",
      ]
      name = "Microsoft.Web/serverFarms"
    }
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "restapi" {
  depends_on     = [module.restapi, azurerm_subnet.restapi]
  app_service_id = module.restapi.id
  subnet_id      = azurerm_subnet.restapi.id
}

resource "azurerm_private_endpoint" "restapi" {
  depends_on          = [module.restapi]
  name                = format("%s-inbound-endpt", module.restapi.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-restapi-privateserviceconnection"
    private_connection_resource_id = module.restapi.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }
  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_private_dns_a_record" "restapi" {
  name                = format("pm-appsrv-restapi-%s", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.restapi.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "restapi-scm" {
  name                = format("pm-appsrv-restapi-%s.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.restapi.private_service_connection.0.private_ip_address]
}

##========================================================================================
##                                                                                      ##
## App Service RESTAPI slot release                                                     ##
##                                                                                      ##
##========================================================================================

# App service slot resource
resource "azurerm_app_service_slot" "restapi-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = "release"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_name    = module.restapi.name
  app_service_plan_id = module.restapi.plan_id

  site_config {
    app_command_line = format("/storage/tools/%s-release/startup_script.sh", var.restapi_name)
    always_on        = "true"
    linux_fx_version = "jbosseap|7-java8"
  }

  app_settings = {
    "APPCONFIG_PATH"                                        = format("/storage/appconfig/%s-release", var.restapi_name)
    "TOOLS_PATH"                                            = format("/storage/tools/%s-release", var.restapi_name)
    "JAVA_OPTS"                                             = local.java_opts
    "LANG"                                                  = local.lang
    "ORACLE_CONNECTION_URL"                                 = local.pp_oracle_connection_url
    "ORACLE_SERVER_ADMIN_FULL_NAME"                         = local.pp_oracle_server_admin_full_name
    "ORACLE_SERVER_ADMIN_PASSWORD"                          = local.pp_oracle_server_admin_password
    "APPINSIGHTS_INSTRUMENTATIONKEY"                        = local.appinsights_instrumentationkey
    "APPINSIGHTS_PROFILERFEATURE_VERSION"                   = local.appinsights_profilerfeature_version
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"                   = local.appinsights_snapshotfeature_version
    "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT"             = local.applicationinsights_configuration_content
    "APPLICATIONINSIGHTS_CONNECTION_STRING"                 = local.applicationinsights_connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION"            = local.applicationinsightsagent_extension_version
    "DiagnosticServices_EXTENSION_VERSION"                  = local.diagnosticservices_extension_version
    "InstrumentationEngine_EXTENSION_VERSION"               = local.instrumentationengine_extension_version
    "SnapshotDebugger_EXTENSION_VERSION"                    = local.snapshotdebugger_extension_version
    "XDT_MicrosoftApplicationInsights_BaseExtensions"       = local.xdt_microsoftapplicationinsights_baseextensions
    "XDT_MicrosoftApplicationInsights_Mode"                 = local.xdt_microsoftapplicationinsights_mode
    "XDT_MicrosoftApplicationInsights_PreemptSdk"           = local.xdt_microsoftapplicationinsights_preemptsdk
    "SAML_SP_METADATA"                                      = local.saml_sp_metadata
    "saml_idp_spidRegistry_metadata_url"                    = local.saml_idp_spidregistry_metadata_url
    "saml_keystore_location"                                = local.saml_keystore_location
    "saml_metadata_sp_filepath"                             = local.saml_metadata_sp_filepath
    "spring_profiles_active"                                = local.spring_profiles_active
    "bancomat_keystore_location"                            = local.bancomat_keystore_location
    "bancomat_keystore_password"                            = local.bancomat_keystore_password
    "org_apache_coyote_http11_DEFAULT_CONNECTION_TIMEOUT"   = local.coyote_default_connection_timeout
    "org_apache_coyote_http11_DEFAULT_KEEP_ALIVE_TIMEOUT"   = local.coyote_default_keep_alive_timeout
    "com_sia_ppt_pcp_SecretKeyStore_SECRET_KEY_STORE_PATH"  = local.secret_key_store_path
    "com_sia_ppt_crypto_KeyManager_PRIVATE_SERVER_KEY_PATH" = local.crypto_private_server_key_path
    "com_sia_ppt_crypto_KeyManager_PUBLIC_SERVER_KEY_PATH"  = local.crypto_public_server_key_path
    "com_sun_mamangement_jmxremote_ssl"                     = local.com_sun_mamangement_jmxremote_ssl
    "HOSTNAME_PM"                                           = local.hostname_pm
    "HOSTNAME_RTD"                                          = local.hostname_rtd
    "STATIC_HOSTNAME"                                       = local.static_hostname
    "NODO_SPC_HOSTNAME"                                     = local.nodo_spc_hostname
    "CITTADINANZA_HOSTNAME"                                 = local.cittadinanza_hostname
    "JIFFY_HOSTNAME"                                        = local.jiffy_hostname
    "LOGGING_WHITE_LIST"                                    = local.logging_white_list
    "CORS_ALLOWED_ORIGINS"                                  = local.cors_allowed_origins
    "HTTP_TIMEOUT"                                          = local.http_timeout
    "MAX_CONNECTION"                                        = local.max_connection
    "REQUEST_TIMEOUT"                                       = local.request_timeout
    "MAX_PER_ROUTE"                                         = local.max_per_route
    "MAX_CONNECTION_CD"                                     = local.max_connection_cd
    "REQUEST_TIMEOUT_CD"                                    = local.request_timeout_cd
    "MAX_PER_ROUTE_CD"                                      = local.max_per_route_cd
    "VPOS_TIMEOUT"                                          = local.vpos_timeout
    "BANCOMAT_TIMEOUT"                                      = local.bancomat_timeout
    "MAX_CONNECTION_BANCOMAT"                               = local.max_connection_bancomat
    "MAX_PER_ROUTE_BANCOMAT"                                = local.max_per_route_bancomat
    "COBADGE_TIMEOUT"                                       = local.cobadge_timeout
    "MAX_CONNECTION_COBADGE"                                = local.max_connection_cobadge
    "MAX_PER_ROUTE_COBADGE"                                 = local.max_per_route_cobadge
    "PM_API_KEY"                                            = local.pm_api_key
    "HSM_ACTIVATION_FLAG"                                   = local.hsm_activation_flag
    "LOG_INTERCEPTOR_PATTERN"                               = local.log_interceptor_pattern
    "JVM_ROUTE"                                             = local.jvm_route
  }
  storage_account {
    name         = "appconfig-release"
    type         = "AzureFiles"
    account_name = azurerm_storage_account.storage.name
    share_name   = "pm-appconfig"
    access_key   = azurerm_storage_account.storage.primary_access_key
    mount_path   = "/storage/appconfig"
  }

  storage_account {
    name         = "tools-release"
    type         = "AzureFiles"
    account_name = azurerm_storage_account.storage.name
    share_name   = "pm-tools"
    access_key   = azurerm_storage_account.storage.primary_access_key
    mount_path   = "/storage/tools"
  }

}

resource "azurerm_app_service_slot_virtual_network_swift_connection" "restapi-release" {
  count          = var.environment != "sit" ? 1 : 0
  slot_name      = azurerm_app_service_slot.restapi-release[0].name
  app_service_id = module.restapi.id
  subnet_id      = azurerm_subnet.restapi.id
}

resource "azurerm_private_endpoint" "restapi-release" {
  depends_on          = [azurerm_app_service_slot.restapi-release[0]]
  count               = var.environment != "sit" ? 1 : 0
  name                = format("%s-inbound-release-endpt", module.restapi.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-release-restapi-privateserviceconnection"
    private_connection_resource_id = module.restapi.id
    is_manual_connection           = false
    subresource_names              = [format("sites-%s", azurerm_app_service_slot.restapi-release[0].name)]
  }
  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_private_dns_a_record" "restapi-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = format("pm-appsrv-restapi-%s-release", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.restapi-release[0].private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "restapi-scm-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = format("pm-appsrv-restapi-%s-release.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.restapi-release[0].private_service_connection.0.private_ip_address]
}