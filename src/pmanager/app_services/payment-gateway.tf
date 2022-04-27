module "payment-gateway" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=app-service-storage-mounts"

  count = var.environment == "sit" ? 1 : 0

  name = format("%s-%s", var.payment_gateway_name, var.environment)

  ftps_state = "AllAllowed"

  plan_name     = format("%s-%s-%s", var.payment_gateway_name, var.plan_name, var.environment)
  plan_type     = "internal"
  plan_sku_size = var.plan_sku
  plan_sku_tier = var.plan_sku_tier
  plan_kind     = var.plan_kind
  plan_reserved = var.plan_reserved
  always_on     = "true"

  resource_group_name = data.azurerm_resource_group.rg.name

  # Linux App Framework and version for the App Service.
  # this app service required java 11
  linux_fx_version = "${var.runtime_name}|7.3-java11"

  # Disable enforcing https connection
  https_only = false

  app_settings = local.app_settings_payment_manager

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

resource "azurerm_subnet" "payment-gateway" {
  count                = var.environment == "sit" ? 1 : 0
  name                 = format("pm-payment-gateway-subnet-%s", var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_outgoing.name
  address_prefixes     = [data.azurerm_key_vault_secret.payment-gateway-outgoing-subnet-address-space.value]
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

resource "azurerm_app_service_virtual_network_swift_connection" "payment-gateway" {
  count          = var.environment == "sit" ? 1 : 0
  depends_on     = [module.payment-gateway, azurerm_subnet.payment-gateway]
  app_service_id = module.payment-gateway[count.index].id
  subnet_id      = azurerm_subnet.payment-gateway[count.index].id
}

resource "azurerm_private_endpoint" "payment-gateway" {
  count               = var.environment == "sit" ? 1 : 0
  depends_on          = [module.payment-gateway]
  name                = format("%s-inbound-endpt", module.payment-gateway[count.index].name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-payment-gateway-privateserviceconnection"
    private_connection_resource_id = module.payment-gateway[count.index].id
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
  count               = var.environment == "sit" ? 1 : 0
  name                = format("pm-appsrv-payment-gateway-%s", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.payment-gateway[count.index].private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "payment-gateway-scm" {
  count               = var.environment == "sit" ? 1 : 0
  name                = format("pm-appsrv-payment-gateway-%s.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.payment-gateway[count.index].private_service_connection.0.private_ip_address]
}

##========================================================================================
##                                                                                      ##
## App Service RESTAPI IO slot release                                                  ##
##                                                                                      ##
##========================================================================================

# App service slot resource
resource "azurerm_app_service_slot" "payment-gateway-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = "release"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_name    = module.payment-gateway[count.index].name
  app_service_plan_id = module.payment-gateway[count.index].plan_id

  site_config {
    app_command_line = format("/storage/tools/%s-release/startup_script.sh", var.payment_gateway_name)
    always_on        = "true"
    linux_fx_version = "jbosseap|7-java8"
  }

  app_settings = local.app_settings_payment_manager

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

resource "azurerm_app_service_slot_virtual_network_swift_connection" "payment-gateway-release" {
  count          = var.environment != "sit" ? 1 : 0
  slot_name      = azurerm_app_service_slot.payment-gateway-release[0].name
  app_service_id = module.payment-gateway[count.index].id
  subnet_id      = azurerm_subnet.payment-gateway[count.index].id
}

resource "azurerm_private_endpoint" "payment-gateway-release" {
  depends_on          = [azurerm_app_service_slot.payment-gateway-release[0]]
  count               = var.environment != "sit" ? 1 : 0
  name                = format("%s-inbound-release-endpt", module.payment-gateway[count.index].name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-release-payment-gateway-privateserviceconnection"
    private_connection_resource_id = module.payment-gateway[count.index].id
    is_manual_connection           = false
    subresource_names              = [format("sites-%s", azurerm_app_service_slot.payment-gateway-release[0].name)]
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
  count               = var.environment != "sit" ? 1 : 0
  name                = format("pm-appsrv-payment-gateway-%s-release", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.payment-gateway-release[0].private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "payment-gateway-scm-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = format("pm-appsrv-payment-gateway-%s-release.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.payment-gateway-release[0].private_service_connection.0.private_ip_address]
}