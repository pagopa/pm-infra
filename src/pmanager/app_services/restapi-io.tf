module "restapi-io" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=app-service-storage-mounts"

  name = format("%s-%s", var.restapi_io_name, var.environment)

  ftps_state = "AllAllowed"

  plan_name     = format("%s-%s-%s", var.restapi_io_name, var.plan_name, var.environment)
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
    APPCONFIG_PATH                                  = format("/storage/appconfig/%s", var.restapi_io_name)
    TOOLS_PATH                                      = format("/storage/tools/%s", var.restapi_io_name)
    JAVA_OPTS                                       = local.java_opts
    LANG                                            = local.lang
    ORACLE_CONNECTION_URL                           = local.pp_oracle_connection_url
    ORACLE_SERVER_ADMIN_FULL_NAME                   = local.pp_oracle_server_admin_full_name
    ORACLE_SERVER_ADMIN_PASSWORD                    = local.pp_oracle_server_admin_password
    "saml.idp.spidRegistry.metadata.url"            = local.saml_idp_spidregistry_metadata_url
    "saml.keystore.location"                        = local.saml_keystore_location
    "saml.metadata.sp.filepath"                     = local.saml_metadata_sp_filepath
    SAML_SP_METADATA                                = local.saml_sp_metadata
    "spring.profiles.active"                        = local.spring_profiles_active
    APPINSIGHTS_INSTRUMENTATIONKEY                  = local.appinsights_instrumentationkey
    APPINSIGHTS_PROFILERFEATURE_VERSION             = local.appinsights_profilerfeature_version
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION             = local.appinsights_snapshotfeature_version
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT       = local.applicationinsights_configuration_content
    APPLICATIONINSIGHTS_CONNECTION_STRING           = local.applicationinsights_connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION      = local.applicationinsightsagent_extension_version
    DiagnosticServices_EXTENSION_VERSION            = local.diagnosticservices_extension_version
    InstrumentationEngine_EXTENSION_VERSION         = local.instrumentationengine_extension_version
    SnapshotDebugger_EXTENSION_VERSION              = local.snapshotdebugger_extension_version
    XDT_MicrosoftApplicationInsights_BaseExtensions = local.xdt_microsoftapplicationinsights_baseextensions
    XDT_MicrosoftApplicationInsights_Mode           = local.xdt_microsoftapplicationinsights_mode
    XDT_MicrosoftApplicationInsights_PreemptSdk     = local.xdt_microsoftapplicationinsights_preemptsdk
    HOSTNAME_PM                                     = local.hostname_pm
    HOSTNAME_RTD                                    = local.hostname_rtd
    STATIC_HOSTNAME                                 = local.static_hostname
    NODO_SPC_HOSTNAME                               = local.nodo_spc_hostname
    CITTADINANZA_HOSTNAME                           = local.cittadinanza_hostname
    JIFFY_HOSTNAME                                  = local.jiffy_hostname
    LOGGING_WHITE_LIST                              = local.logging_white_list
    "bancomat.keystore.location"                    = local.bancomat_keystore_location
    CORS_ALLOWED_ORIGINS                            = local.cors_allowed_origins
  }

  app_command_line = format("/storage/tools/%s/startup_script.sh", var.restapi_io_name)

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

resource "azurerm_subnet" "restapi-io" {
  name                 = format("pm-restapi-io-subnet-%s", var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_outgoing.name
  address_prefixes     = [data.azurerm_key_vault_secret.restapi-io-outgoing-subnet-address-space.value]
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

resource "azurerm_app_service_virtual_network_swift_connection" "restapi-io" {
  depends_on     = [module.restapi-io, azurerm_subnet.restapi-io]
  app_service_id = module.restapi-io.id
  subnet_id      = azurerm_subnet.restapi-io.id
}

resource "azurerm_private_endpoint" "restapi-io" {
  depends_on          = [module.restapi-io]
  name                = format("%s-inbound-endpt", module.restapi-io.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-restapi-io-privateserviceconnection"
    private_connection_resource_id = module.restapi-io.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }
  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_private_dns_a_record" "restapi-io" {
  name                = format("pm-appsrv-restapi-io-%s", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.restapi-io.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "restapi-io-scm" {
  name                = format("pm-appsrv-restapi-io-%s.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.restapi-io.private_service_connection.0.private_ip_address]
}

##========================================================================================
##                                                                                      ##
## App Service RESTAPI IO slot release                                                  ##
##                                                                                      ##
##========================================================================================

# App service slot resource
resource "azurerm_app_service_slot" "restapi-io-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = "release"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_name    = module.restapi-io.name
  app_service_plan_id = module.restapi-io.plan_id

  site_config {
    app_command_line = format("/storage/tools/%s-release/startup_script.sh", var.restapi_io_name)
    always_on        = "true"
    linux_fx_version = "jbosseap|7-java8"
  }

  app_settings = {
    "APPCONFIG_PATH"                                  = format("/storage/appconfig/%s-release", var.restapi_io_name)
    "TOOLS_PATH"                                      = format("/storage/tools/%s-release", var.restapi_io_name)
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
    HOSTNAME_PM                                       = local.hostname_pm
    HOSTNAME_RTD                                      = local.hostname_rtd
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

resource "azurerm_app_service_slot_virtual_network_swift_connection" "restapi-io-release" {
  count          = var.environment != "sit" ? 1 : 0
  slot_name      = azurerm_app_service_slot.restapi-io-release[0].name
  app_service_id = module.restapi-io.id
  subnet_id      = azurerm_subnet.restapi-io.id
}

resource "azurerm_private_endpoint" "restapi-io-release" {
  depends_on          = [azurerm_app_service_slot.restapi-io-release[0]]
  count               = var.environment != "sit" ? 1 : 0
  name                = format("%s-inbound-release-endpt", module.restapi-io.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-release-restapi-io-privateserviceconnection"
    private_connection_resource_id = module.restapi-io.id
    is_manual_connection           = false
    subresource_names              = [format("sites-%s", azurerm_app_service_slot.restapi-io-release[0].name)]
  }
  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_private_dns_a_record" "restapi-io-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = format("pm-appsrv-restapi-io-%s-release", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.restapi-io-release[0].private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "restapi-io-scm-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = format("pm-appsrv-restapi-io-%s-release.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.restapi-io-release[0].private_service_connection.0.private_ip_address]
}