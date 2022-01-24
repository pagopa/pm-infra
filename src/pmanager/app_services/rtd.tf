module "rtd" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.0.19"

  name = format("%s-%s", var.rtd_name, var.environment)

  ftps_state = "AllAllowed"

  plan_name     = format("%s-%s-%s", var.rtd_name, var.plan_name, var.environment)
  plan_type     = "internal"
  plan_sku_size = var.plan_sku
  plan_sku_tier = var.plan_sku_tier
  plan_kind     = var.plan_kind
  plan_reserved = var.plan_reserved
  always_on     = "true"

  resource_group_name = data.azurerm_resource_group.rg.name

  # Linux App Framework and version for the App Service.
  linux_fx_version = "${var.runtime_name}|${var.runtime_version}"

  app_settings = {
    APPCONFIG_PATH                    = format("/storage/appconfig/%s", var.rtd_name)
    TOOLS_PATH                        = format("/storage/tools/%s", var.rtd_name)
    JAVA_OPTS                         = var.java_opts
    LANG                              = var.system_encoding
    ORACLE_CONNECTION_URL             = data.azurerm_key_vault_secret.oracle-connection-url.value
    RTD_ORACLE_SERVER_ADMIN_FULL_NAME = "RTD_USER"
    RTD_ORACLE_SERVER_ADMIN_PASSWORD  = "RTD_USER"
    #WEBSITE_HTTPLOGGING_RETENTION_DAYS              = var.http_log_retention_days
    "saml.idp.spidRegistry.metadata.url"            = "/home/site/appconfig/spid-entities-idps_local.xml"
    "saml.keystore.location"                        = "file:/home/site/appconfig/saml_spid_sit.jks"
    "saml.metadata.sp.filepath"                     = "/home/site/appconfig/sp_metadata.xml"
    SAML_SP_METADATA                                = "/home/site/appconfig/sp_metadata.xml"
    "spring.profiles.active"                        = var.environment
    APPINSIGHTS_INSTRUMENTATIONKEY                  = var.appinsight_name != "" ? data.azurerm_application_insights.appinsight[0].instrumentation_key : ""
    APPINSIGHTS_PROFILERFEATURE_VERSION             = "1.0.0"
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION             = "1.0.0"
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT       = ""
    APPLICATIONINSIGHTS_CONNECTION_STRING           = var.appinsight_name != "" ? data.azurerm_application_insights.appinsight[0].connection_string : ""
    ApplicationInsightsAgent_EXTENSION_VERSION      = "~3"
    DiagnosticServices_EXTENSION_VERSION            = "~3"
    InstrumentationEngine_EXTENSION_VERSION         = "disabled"
    SnapshotDebugger_EXTENSION_VERSION              = "disabled"
    XDT_MicrosoftApplicationInsights_BaseExtensions = "disabled"
    XDT_MicrosoftApplicationInsights_Mode           = "recommended"
    XDT_MicrosoftApplicationInsights_PreemptSdk     = "disabled"
    HOSTNAME                                        = var.hostname
    HOSTNAME_RTD                                    = var.hostname_rtd
    STATIC_HOSTNAME                                 = var.static_hostname
    NODO_SPC_HOSTNAME                               = var.nodo_spc_hostname
    CITTADINANZA_HOSTNAME                           = var.cittadinanza_hostname
    JIFFY_HOSTNAME                                  = var.jiffy_hostname
    LOGGING_WHITE_LIST                              = var.logging_white_list
    "bancomat.keystore.location"                    = var.bancomat_keystore_location
    CORS_ALLOWED_ORIGINS                            = var.cors_allowed_origins
  }

  app_command_line = "/home/site/deployments/tools/startup_script.sh"

  tags = {
    kind        = "app service",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_subnet" "rtd" {
  name                 = format("pm-rtd-subnet-%s", var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_outgoing.name
  address_prefixes     = [data.azurerm_key_vault_secret.rtd-outgoing-subnet-address-space.value]
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


resource "azurerm_app_service_virtual_network_swift_connection" "rtd" {
  depends_on     = [module.rtd, azurerm_subnet.rtd]
  app_service_id = module.rtd.id
  subnet_id      = azurerm_subnet.rtd.id
}

resource "azurerm_private_endpoint" "rtd" {
  depends_on          = [module.rtd]
  name                = format("%s-inbound-endpt", module.rtd.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-rtd-privateserviceconnection"
    private_connection_resource_id = module.rtd.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }
  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_private_dns_a_record" "rtd" {
  name                = format("pm-appsrv-rtd-%s", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.rtd.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "rtd-scm" {
  name                = format("pm-appsrv-rtd-%s.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.rtd.private_service_connection.0.private_ip_address]
}