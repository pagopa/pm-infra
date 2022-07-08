module "restapi-io" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.15.1"

  depends_on = [
    azurerm_subnet.restapi-io
  ]

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
  #https_only = false

  app_settings = local.app_settings

  app_command_line = "/home/site/deployments/tools/startup_script.sh"

  # Add health check path
  health_check_path = "/pp-restapi-CD/healthcheck"

  tags = {
    kind        = "app service",
    environment = var.environment,
    standard    = var.standard,
    TS_Code     = var.tsi,
    CreatedBy   = "Terraform"
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
  depends_on          = [module.restapi-io, azurerm_subnet.restapi-io]
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
    standard    = var.standard,
    TS_Code     = var.tsi,
    CreatedBy   = "Terraform"
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

  app_settings = local.app_settings

  # Add health check path
  # health_check_path = "/pp-restapi-CD/healthcheck"


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
    standard    = var.standard,
    TS_Code     = var.tsi,
    CreatedBy   = "Terraform"
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