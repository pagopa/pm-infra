module "payment-gateway" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.15.1"

  depends_on = [
    azurerm_subnet.unique
  ]

  name = format("%s-%s", var.payment_gateway_name, var.environment)

  ftps_state = "AllAllowed"

  plan_name           = format("%s-%s-%s", var.payment_gateway_name, var.plan_name, var.environment)
  plan_type           = "external"
  plan_id             = azurerm_app_service_plan.unique.id
  plan_sku_size       = var.plan_sku
  plan_sku_tier       = var.plan_sku_tier
  plan_kind           = var.plan_kind
  plan_reserved       = var.plan_reserved
  always_on           = "true"
  client_cert_enabled = "true"


  resource_group_name = data.azurerm_resource_group.rg.name

  # Linux App Framework and version for the App Service.
  # this app service required java 11
  linux_fx_version = "${var.runtime_name}|7.3.9-java11"

  # Disable enforcing https connection
  #https_only = false

  app_settings = local.app_settings_payment_gateway

  app_command_line = "/home/site/deployments/tools/startup_script.sh"

  # Add health check path
  health_check_path = "/payment-gateway/healthcheck"

  tags = {
    kind        = "app service",
    environment = var.environment,
    standard    = var.standard,
    TS_Code     = var.tsi,
    CreatedBy   = "Terraform"
  }
}

# resource "azurerm_subnet" "payment-gateway" {
#   name                 = format("pm-payment-gateway-subnet-%s", var.environment)
#   resource_group_name  = data.azurerm_resource_group.rg_vnet.name
#   virtual_network_name = data.azurerm_virtual_network.vnet_outgoing.name
#   address_prefixes     = [data.azurerm_key_vault_secret.unique-outgoing-subnet-address-space.value]
#   delegation {
#     name = "Microsoft.Web.serverFarms"

#     service_delegation {
#       actions = [
#         "Microsoft.Network/virtualNetworks/subnets/action",
#       ]
#       name = "Microsoft.Web/serverFarms"
#     }
#   }
# }

resource "azurerm_app_service_virtual_network_swift_connection" "payment-gateway" {
  depends_on     = [module.payment-gateway, azurerm_subnet.unique]
  app_service_id = module.payment-gateway.id
  subnet_id      = azurerm_subnet.unique.id
}

resource "azurerm_private_endpoint" "payment-gateway" {
  depends_on          = [module.payment-gateway, azurerm_subnet.unique]
  name                = format("%s-inbound-endpt", module.payment-gateway.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-payment-gateway-privateserviceconnection"
    private_connection_resource_id = module.payment-gateway.id
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

resource "azurerm_private_dns_a_record" "payment-gateway" {
  name                = format("pm-appsrv-payment-gateway-%s", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.payment-gateway.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "payment-gateway-scm" {
  name                = format("pm-appsrv-payment-gateway-%s.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.payment-gateway.private_service_connection.0.private_ip_address]
}

##========================================================================================
##                                                                                      ##
## App Service RESTAPI IO slot release                                                  ##
##                                                                                      ##
##========================================================================================

# App service slot resource
resource "azurerm_app_service_slot" "payment-gateway-release" {
  name                = "release"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_name    = module.payment-gateway.name
  app_service_plan_id = module.payment-gateway.plan_id

  site_config {
    app_command_line = "/home/site/deployments/tools/startup_script.sh"

    # Add health check path
    health_check_path = "/payment-gateway/healthcheck"
    always_on         = "true"
    linux_fx_version  = "${var.runtime_name}|7.3.9-java11"
  }

  app_settings = local.app_settings_payment_gateway

}
resource "azurerm_app_service_slot_virtual_network_swift_connection" "payment-gateway-release" {
  slot_name      = azurerm_app_service_slot.payment-gateway-release.name
  app_service_id = module.payment-gateway.id
  subnet_id      = azurerm_subnet.unique.id
}

resource "azurerm_private_endpoint" "payment-gateway-release" {
  depends_on          = [azurerm_app_service_slot.payment-gateway-release]
  name                = format("%s-inbound-release-endpt", module.payment-gateway.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-release-payment-gateway-privateserviceconnection"
    private_connection_resource_id = module.payment-gateway.id
    is_manual_connection           = false
    subresource_names              = [format("sites-%s", azurerm_app_service_slot.payment-gateway-release.name)]
  }
  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard,
    TS_Code     = var.tsi,
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_private_dns_a_record" "payment-gateway-release" {
  name                = format("pm-appsrv-payment-gateway-%s-release", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.payment-gateway-release.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "payment-gateway-scm-release" {
  name                = format("pm-appsrv-payment-gateway-%s-release.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.payment-gateway-release.private_service_connection.0.private_ip_address]
}
