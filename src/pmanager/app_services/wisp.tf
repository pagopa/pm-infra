module "wisp" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=app-service-storage-mounts"

  name = format("%s-%s", var.wisp_name, var.environment)

  ftps_state = "AllAllowed"

  plan_name     = format("%s-%s-%s", var.wisp_name, var.plan_name, var.environment)
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
    APPCONFIG_PATH                                          = format("/storage/appconfig/%s", var.wisp_name)
    TOOLS_PATH                                              = format("/storage/tools/%s", var.wisp_name)
    JAVA_OPTS                                               = local.java_opts
    LANG                                                    = local.lang
    ORACLE_CONNECTION_URL                                   = local.pp_oracle_connection_url
    ORACLE_SERVER_ADMIN_FULL_NAME                           = local.pp_oracle_server_admin_full_name
    ORACLE_SERVER_ADMIN_PASSWORD                            = local.pp_oracle_server_admin_password
    "saml.idp.spidRegistry.metadata.url"                    = local.saml_idp_spidregistry_metadata_url
    "saml.keystore.location"                                = local.saml_keystore_location
    "saml.metadata.sp.filepath"                             = local.saml_metadata_sp_filepath
    SAML_SP_METADATA                                        = local.saml_sp_metadata
    "spring.profiles.active"                                = local.spring_profiles_active
    APPINSIGHTS_INSTRUMENTATIONKEY                          = local.appinsights_instrumentationkey
    APPINSIGHTS_PROFILERFEATURE_VERSION                     = local.appinsights_profilerfeature_version
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION                     = local.appinsights_snapshotfeature_version
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT               = local.applicationinsights_configuration_content
    APPLICATIONINSIGHTS_CONNECTION_STRING                   = local.applicationinsights_connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION              = local.applicationinsightsagent_extension_version
    DiagnosticServices_EXTENSION_VERSION                    = local.diagnosticservices_extension_version
    InstrumentationEngine_EXTENSION_VERSION                 = local.instrumentationengine_extension_version
    SnapshotDebugger_EXTENSION_VERSION                      = local.snapshotdebugger_extension_version
    XDT_MicrosoftApplicationInsights_BaseExtensions         = local.xdt_microsoftapplicationinsights_baseextensions
    XDT_MicrosoftApplicationInsights_Mode                   = local.xdt_microsoftapplicationinsights_mode
    XDT_MicrosoftApplicationInsights_PreemptSdk             = local.xdt_microsoftapplicationinsights_preemptsdk
    HOSTNAME_PM                                             = local.hostname_pm
    HOSTNAME_RTD                                            = local.hostname_rtd
    STATIC_HOSTNAME                                         = local.static_hostname
    NODO_SPC_HOSTNAME                                       = local.nodo_spc_hostname
    CITTADINANZA_HOSTNAME                                   = local.cittadinanza_hostname
    JIFFY_HOSTNAME                                          = local.jiffy_hostname
    LOGGING_WHITE_LIST                                      = local.logging_white_list
    "bancomat.keystore.location"                            = local.bancomat_keystore_location
    CORS_ALLOWED_ORIGINS                                    = local.cors_allowed_origins
    HTTP_TIMEOUT                                            = local.http_timeout
    MAX_CONNECTION                                          = local.max_connection
    REQUEST_TIMEOUT                                         = local.request_timeout
    MAX_PER_ROUTE                                           = local.max_per_route
    MAX_CONNECTION_CD                                       = local.max_connection_cd
    REQUEST_TIMEOUT_CD                                      = local.request_timeout_cd
    MAX_PER_ROUTE_CD                                        = local.max_per_route_cd
    VPOS_TIMEOUT                                            = local.vpos_timeout
    BANCOMAT_TIMEOUT                                        = local.bancomat_timeout
    MAX_CONNECTION_BANCOMAT                                 = local.max_connection_bancomat
    MAX_PER_ROUTE_BANCOMAT                                  = local.max_per_route_bancomat
    COBADGE_TIMEOUT                                         = local.cobadge_timeout
    MAX_CONNECTION_COBADGE                                  = local.max_connection_cobadge
    MAX_PER_ROUTE_COBADGE                                   = local.max_per_route_cobadge
    PM_API_KEY                                              = local.pm_api_key
    "org.apache.coyote.http11.DEFAULT_CONNECTION_TIMEOUT"   = local.coyote_default_connection_timeout
    "org.apache.coyote.http11.DEFAULT_KEEP_ALIVE_TIMEOUT"   = local.coyote_default_keep_alive_timeout
    "com.sia.ppt.pcp.SecretKeyStore.SECRET_KEY_STORE_PATH"  = local.secret_key_store_path
    "com.sia.ppt.crypto.KeyManager.PRIVATE_SERVER_KEY_PATH" = local.crypto_private_server_key_path
    "com.sia.ppt.crypto.KeyManager.PUBLIC_SERVER_KEY_PATH"  = local.crypto_public_server_key_path
    HSM_ACTIVATION_FLAG                                     = local.hsm_activation_flag
    "com.sun.mamangement.jmxremote.ssl"                     = local.com_sun_mamangement_jmxremote_ssl
    LOG_INTERCEPTOR_PATTERN                                 = local.log_interceptor_pattern
  }

  app_command_line = format("/storage/tools/%s/startup_script.sh", var.wisp_name)

  storage_mounts = [{
    name         = "appconfig"
    type         = "AzureFiles"
    account_name = azurerm_storage_account.storage.name
    share_name   = "pm-appconfig"
    access_key   = azurerm_storage_account.storage.primary_access_key
    mount_path   = "/storage/appconfig"
    },
    {
      name         = "tools"
      type         = "AzureFiles"
      account_name = azurerm_storage_account.storage.name
      share_name   = "pm-tools"
      access_key   = azurerm_storage_account.storage.primary_access_key
      mount_path   = "/storage/tools"
    }
  ]

  tags = {
    kind        = "app service",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_subnet" "wisp" {
  name                 = format("pm-wisp-subnet-%s", var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_outgoing.name
  address_prefixes     = [data.azurerm_key_vault_secret.wisp-outgoing-subnet-address-space.value]
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


resource "azurerm_app_service_virtual_network_swift_connection" "wisp" {
  depends_on     = [module.wisp, azurerm_subnet.wisp]
  app_service_id = module.wisp.id
  subnet_id      = azurerm_subnet.wisp.id
}

resource "azurerm_private_endpoint" "wisp" {
  depends_on          = [module.wisp]
  name                = format("%s-inbound-endpt", module.wisp.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-wisp-privateserviceconnection"
    private_connection_resource_id = module.wisp.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }
  tags = {
    kind        = "app service",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_private_dns_a_record" "wisp" {
  name                = format("pm-appsrv-wisp-%s", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.wisp.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "wisp-scm" {
  name                = format("pm-appsrv-wisp-%s.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.wisp.private_service_connection.0.private_ip_address]
}

##========================================================================================
##                                                                                      ##
## App Service WISP slot release                                                        ##
##                                                                                      ##
##========================================================================================

# App service slot resource
resource "azurerm_app_service_slot" "wisp-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = "release"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_name    = module.wisp.name
  app_service_plan_id = module.wisp.plan_id

  site_config {
    app_command_line = format("/storage/tools/%s-release/startup_script.sh", var.wisp_name)
    always_on        = "true"
    linux_fx_version = "jbosseap|7-java8"
  }

  app_settings = {
    "APPCONFIG_PATH"                                  = format("/storage/appconfig/%s-release", var.wisp_name)
    "TOOLS_PATH"                                      = format("/storage/tools/%s-release", var.wisp_name)
    "JAVA_OPTS"                                       = local.java_opts
    "LANG"                                            = local.lang
    "ORACLE_CONNECTION_URL"                           = local.pp_oracle_connection_url
    "ORACLE_SERVER_ADMIN_FULL_NAME"                   = local.pp_oracle_server_admin_full_name
    "ORACLE_SERVER_ADMIN_PASSWORD"                    = local.pp_oracle_server_admin_password
    "saml.idp.spidRegistry.metadata.url"              = local.saml_idp_spidregistry_metadata_url
    "saml.keystore.location"                          = local.saml_keystore_location
    "saml.metadata.sp.filepath"                       = local.saml_metadata_sp_filepath
    "SAML_SP_METADATA"                                = local.saml_sp_metadata
    "spring.profiles.active"                          = local.spring_profiles_active
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = local.appinsights_instrumentationkey
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = local.appinsights_profilerfeature_version
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = local.appinsights_snapshotfeature_version
    "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT"       = local.applicationinsights_configuration_content
    "APPLICATIONINSIGHTS_CONNECTION_STRING"           = local.applicationinsights_connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = local.applicationinsightsagent_extension_version
    "DiagnosticServices_EXTENSION_VERSION"            = local.diagnosticservices_extension_version
    "InstrumentationEngine_EXTENSION_VERSION"         = local.instrumentationengine_extension_version
    "SnapshotDebugger_EXTENSION_VERSION"              = local.snapshotdebugger_extension_version
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = local.xdt_microsoftapplicationinsights_baseextensions
    "XDT_MicrosoftApplicationInsights_Mode"           = local.xdt_microsoftapplicationinsights_mode
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = local.xdt_microsoftapplicationinsights_preemptsdk
    "HOSTNAME_PM"                                     = local.hostname_pm
    "HOSTNAME_RTD"                                    = local.hostname_rtd
    "STATIC_HOSTNAME"                                 = local.static_hostname
    "NODO_SPC_HOSTNAME"                               = local.nodo_spc_hostname
    "CITTADINANZA_HOSTNAME"                           = local.cittadinanza_hostname
    "JIFFY_HOSTNAME"                                  = local.jiffy_hostname
    "LOGGING_WHITE_LIST"                              = local.logging_white_list
    "bancomat.keystore.location"                      = local.bancomat_keystore_location
    "CORS_ALLOWED_ORIGINS"                            = local.cors_allowed_origins
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

resource "azurerm_app_service_slot_virtual_network_swift_connection" "wisp-release" {
  count          = var.environment != "sit" ? 1 : 0
  slot_name      = azurerm_app_service_slot.wisp-release[0].name
  app_service_id = module.wisp.id
  subnet_id      = azurerm_subnet.wisp.id
}

resource "azurerm_private_endpoint" "wisp-release" {
  depends_on          = [azurerm_app_service_slot.wisp-release[0]]
  count               = var.environment != "sit" ? 1 : 0
  name                = format("%s-inbound-release-endpt", module.wisp.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-release-wisp-privateserviceconnection"
    private_connection_resource_id = module.wisp.id
    is_manual_connection           = false
    subresource_names              = [format("sites-%s", azurerm_app_service_slot.wisp-release[0].name)]
  }
  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_private_dns_a_record" "wisp-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = format("pm-appsrv-wisp-%s-release", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.wisp-release[0].private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "wisp-scm-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = format("pm-appsrv-wisp-%s-release.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.wisp-release[0].private_service_connection.0.private_ip_address]
}