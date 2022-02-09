
resource "azurerm_storage_account" "storage" {
  name                     = format("pmappservicestorage%s", var.environment)
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    kind        = "storage",
    environment = var.environment,
    standard    = var.standard
  }
}

resource "azurerm_storage_share" "storage-appconfig" {
  name                 = "pm-appconfig"
  storage_account_name = azurerm_storage_account.storage.name
  quota                = 50
}

resource "azurerm_storage_share" "storage-tools" {
  name                 = "pm-tools"
  storage_account_name = azurerm_storage_account.storage.name
  quota                = 50
}

##──── Private endpoint connection ───────────────────────────────────────────────────────
resource "azurerm_private_endpoint" "storage-endpt" {
  name                = format("pm-storage-account-%s-%s-endpt", azurerm_storage_account.storage.name, var.environment)
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = data.azurerm_subnet.inboundsubnet.id

  private_service_connection {
    name                           = "pm-storage-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }
}

# A dns entry
resource "azurerm_private_dns_a_record" "storage" {
  name                = format("%s", azurerm_storage_account.storage.name)
  zone_name           = data.azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg_zone.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.storage-endpt.private_service_connection.0.private_ip_address]
}

##========================================================================================
##                                                                                      ##
## APP SERVICE                                                                          ##
##                                                                                      ##
##========================================================================================

##──── App services storage appconfig ────────────────────────────────────────────────────
resource "azurerm_storage_share_directory" "appconfig-admin-panel" {
  name                 = var.admin_panel_name
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-batch" {
  name                 = var.batch_name
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-logging" {
  name                 = var.logging_name
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-restapi-io" {
  name                 = var.restapi_io_name
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-restapi" {
  name                 = var.restapi_name
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-rtd" {
  name                 = var.rtd_name
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-wisp" {
  name                 = var.wisp_name
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

##──── App service storage tools ─────────────────────────────────────────────────────────
resource "azurerm_storage_share_directory" "tools-admin-panel" {
  name                 = var.admin_panel_name
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-batch" {
  name                 = var.batch_name
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-logging" {
  name                 = var.logging_name
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-restapi-io" {
  name                 = var.restapi_io_name
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-restapi" {
  name                 = var.restapi_name
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-rtd" {
  name                 = var.rtd_name
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-wisp" {
  name                 = var.wisp_name
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

##========================================================================================
##                                                                                      ##
## APP SERVICE RELEASE                                                                  ##
##                                                                                      ##
##========================================================================================
##──── App service appconfig release ─────────────────────────────────────────────────────
resource "azurerm_storage_share_directory" "appconfig-admin-panel-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.admin_panel_name)
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-batch-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.batch_name)
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-logging-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.logging_name)
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-restapi-io-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.restapi_io_name)
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-restapi-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.restapi_name)
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-rtd-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.rtd_name)
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "appconfig-wisp-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.wisp_name)
  share_name           = azurerm_storage_share.storage-appconfig.name
  storage_account_name = azurerm_storage_account.storage.name
}

##──── App service tools release ─────────────────────────────────────────────────────────

resource "azurerm_storage_share_directory" "tools-admin-panel-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.admin_panel_name)
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-batch-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.batch_name)
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-logging-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.logging_name)
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-restapi-io-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.restapi_io_name)
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-restapi-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.restapi_name)
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-rtd-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.rtd_name)
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}

resource "azurerm_storage_share_directory" "tools-wisp-release" {
  count                = var.environment != "sit" ? 1 : 0
  name                 = format("%s-release", var.wisp_name)
  share_name           = azurerm_storage_share.storage-tools.name
  storage_account_name = azurerm_storage_account.storage.name
}