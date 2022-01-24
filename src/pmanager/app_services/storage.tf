
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