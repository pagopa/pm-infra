module "batch" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=app-service-storage-mounts"

  name = format("%s-%s", var.batch_name, var.environment)

  ftps_state = "AllAllowed"

  plan_name     = format("%s-%s-%s", var.batch_name, var.plan_name, var.environment)
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

  # App service settings, take from locals
  app_settings = local.app_settings

  app_command_line = "/home/site/deployments/tools/startup_script.sh"

  # Add health check path
  health_check_path = "/pp-ejbBatch/healthcheck"

  tags = {
    kind        = "app service",
    environment = var.environment,
    standard    = var.standard,
    TS_Code     = var.tsi,
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_subnet" "batch" {
  name                 = format("pm-batch-subnet-%s", var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_outgoing.name
  address_prefixes     = [data.azurerm_key_vault_secret.batch-outgoing-subnet-address-space.value]
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

resource "azurerm_app_service_virtual_network_swift_connection" "batch" {
  depends_on     = [module.batch, azurerm_subnet.batch]
  app_service_id = module.batch.id
  subnet_id      = azurerm_subnet.batch.id
}


resource "azurerm_private_endpoint" "batch" {
  depends_on          = [module.batch]
  name                = format("%s-inbound-endpt", module.batch.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-batch-privateserviceconnection"
    private_connection_resource_id = module.batch.id
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

resource "azurerm_private_dns_a_record" "batch" {
  name                = format("pm-appsrv-batch-%s", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.batch.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "batch-scm" {
  name                = format("pm-appsrv-batch-%s.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.batch.private_service_connection.0.private_ip_address]
}

##========================================================================================
##                                                                                      ##
## App Service BATCH slot release                                                       ##
##                                                                                      ##
##========================================================================================

# App service slot resource
resource "azurerm_app_service_slot" "batch-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = "release"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_name    = module.batch.name
  app_service_plan_id = module.batch.plan_id

  site_config {
    app_command_line = format("/storage/tools/%s-release/startup_script.sh", var.batch_name)
    always_on        = "true"
    linux_fx_version = "jbosseap|7-java8"
  }

  # App service slot settings
  app_settings = local.app_settings

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

resource "azurerm_app_service_slot_virtual_network_swift_connection" "batch-release" {
  count          = var.environment != "sit" ? 1 : 0
  slot_name      = azurerm_app_service_slot.batch-release[0].name
  app_service_id = module.batch.id
  subnet_id      = azurerm_subnet.batch.id
}

resource "azurerm_private_endpoint" "batch-release" {
  depends_on          = [azurerm_app_service_slot.batch-release[0]]
  count               = var.environment != "sit" ? 1 : 0
  name                = format("%s-inbound-release-endpt", module.batch.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id


  private_service_connection {
    name                           = "pm-release-batch-privateserviceconnection"
    private_connection_resource_id = module.batch.id
    is_manual_connection           = false
    subresource_names              = [format("sites-%s", azurerm_app_service_slot.batch-release[0].name)]
  }
  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard,
    TS_Code     = var.tsi,
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_private_dns_a_record" "batch-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = format("pm-appsrv-batch-%s-release", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.batch-release[0].private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_a_record" "batch-scm-release" {
  count               = var.environment != "sit" ? 1 : 0
  name                = format("pm-appsrv-batch-%s-release.scm", var.environment)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.batch-release[0].private_service_connection.0.private_ip_address]
}