module "rtd" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.0.19"

  name = format("pm-appsrv-rtd-%s", var.environment)

  ftps_state = "AllAllowed"

  plan_name     = "pm-rtd-plan"
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
    JAVA_OPTS                          = var.java_opts
    LANG                               = var.system_encoding
    ORACLE_CONNECTION_URL              = data.azurerm_key_vault_secret.oracle-connection-url.value
    ORACLE_SERVER_ADMIN_FULL_NAME      = data.azurerm_key_vault_secret.oracle-server-agid-user.value
    ORACLE_SERVER_ADMIN_PASSWORD       = data.azurerm_key_vault_secret.oracle-server-agid-user-password.value
    WEBSITE_HTTPLOGGING_RETENTION_DAYS = var.http_log_retention_days
    "spring.config.location"           = var.spring_config_location    
  }

  app_command_line = "/home/site/deployments/tools/startup_script.sh"

  tags = {
    environment = var.environment
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
    environment = var.environment
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