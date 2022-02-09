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
    APPCONFIG_PATH                                  = format("/storage/appconfig/%s", var.restapi_name)
    TOOLS_PATH                                      = format("/storage/tools/%s", var.restapi_name)
    JAVA_OPTS                                       = var.java_opts
    LANG                                            = var.system_encoding
    ORACLE_CONNECTION_URL                           = data.azurerm_key_vault_secret.oracle-connection-url.value
    ORACLE_SERVER_ADMIN_FULL_NAME                   = data.azurerm_key_vault_secret.oracle-server-agid-user.value
    ORACLE_SERVER_ADMIN_PASSWORD                    = data.azurerm_key_vault_secret.oracle-server-agid-user-password.value
    "saml.idp.spidRegistry.metadata.url"            = "/home/site/appconfig/spid-entities-idps_local.xml"
    "saml.keystore.location"                        = "file:/home/site/appconfig/saml_spid_sit.jks"
    "saml.metadata.sp.filepath"                     = "/home/site/appconfig/sp_metadata.xml"
    SAML_SP_METADATA                                = "/home/site/appconfig/sp_metadata.xml"
    "spring.profiles.active"                        = var.environment
    APPINSIGHTS_INSTRUMENTATIONKEY                  = var.appinsight_name != "" ? data.azurerm_application_insights.appinsight[0].instrumentation_key : var.appinsight_instrumentation_key
    APPINSIGHTS_PROFILERFEATURE_VERSION             = "1.0.0"
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION             = "1.0.0"
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT       = ""
    APPLICATIONINSIGHTS_CONNECTION_STRING           = var.appinsight_name != "" ? data.azurerm_application_insights.appinsight[0].instrumentation_key : var.appinsight_connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION      = "~3"
    DiagnosticServices_EXTENSION_VERSION            = "~3"
    InstrumentationEngine_EXTENSION_VERSION         = "disabled"
    SnapshotDebugger_EXTENSION_VERSION              = "disabled"
    XDT_MicrosoftApplicationInsights_BaseExtensions = "disabled"
    XDT_MicrosoftApplicationInsights_Mode           = "recommended"
    XDT_MicrosoftApplicationInsights_PreemptSdk     = "disabled"
    HOSTNAME_PM                                     = var.hostname
    HOSTNAME_RTD                                    = var.hostname_rtd
    STATIC_HOSTNAME                                 = var.static_hostname
    NODO_SPC_HOSTNAME                               = var.nodo_spc_hostname
    CITTADINANZA_HOSTNAME                           = var.cittadinanza_hostname
    JIFFY_HOSTNAME                                  = var.jiffy_hostname
    LOGGING_WHITE_LIST                              = var.logging_white_list
    "bancomat.keystore.location"                    = var.bancomat_keystore_location
    CORS_ALLOWED_ORIGINS                            = var.cors_allowed_origins
  }

  app_command_line = format("/storage/tools/%s/startup_script.sh", var.restapi_name)

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
    "APPCONFIG_PATH"                                  = format("/storage/appconfig/%s-release", var.restapi_name)
    "TOOLS_PATH"                                      = format("/storage/tools/%s-release", var.restapi_name)
    "JAVA_OPTS"                                       = var.java_opts
    "LANG"                                            = var.system_encoding
    "ORACLE_CONNECTION_URL"                           = data.azurerm_key_vault_secret.oracle-connection-url.value
    "ORACLE_SERVER_ADMIN_FULL_NAME"                   = data.azurerm_key_vault_secret.oracle-server-agid-user.value
    "ORACLE_SERVER_ADMIN_PASSWORD"                    = data.azurerm_key_vault_secret.oracle-server-agid-user-password.value
    "saml.idp.spidRegistry.metadata.url"              = "/home/site/appconfig/spid-entities-idps_local.xml"
    "saml.keystore.location"                          = "file:/home/site/appconfig/saml_spid_sit.jks"
    "saml.metadata.sp.filepath"                       = "/home/site/appconfig/sp_metadata.xml"
    "SAML_SP_METADATA"                                = "/home/site/appconfig/sp_metadata.xml"
    "spring.profiles.active"                          = var.environment
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = var.appinsight_name != "" ? data.azurerm_application_insights.appinsight[0].instrumentation_key : var.appinsight_instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
    "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT"       = ""
    "APPLICATIONINSIGHTS_CONNECTION_STRING"           = var.appinsight_name != "" ? data.azurerm_application_insights.appinsight[0].instrumentation_key : var.appinsight_connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3"
    "DiagnosticServices_EXTENSION_VERSION"            = "~3"
    "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
    "HOSTNAME_PM"                                     = var.hostname
    "HOSTNAME_RTD"                                    = var.hostname_rtd
    "STATIC_HOSTNAME"                                 = var.static_hostname
    "NODO_SPC_HOSTNAME"                               = var.nodo_spc_hostname
    "CITTADINANZA_HOSTNAME"                           = var.cittadinanza_hostname
    "JIFFY_HOSTNAME"                                  = var.jiffy_hostname
    "LOGGING_WHITE_LIST"                              = var.logging_white_list
    "bancomat.keystore.location"                      = var.bancomat_keystore_location
    "CORS_ALLOWED_ORIGINS"                            = var.cors_allowed_origins
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