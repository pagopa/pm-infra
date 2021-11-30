resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.location
}

module "web_app" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v1.0.86"

  name = format("%s-%s", var.name, var.environment)

  ftps_state = "AllAllowed"

  plan_name     = "${var.name}-plan"
  plan_sku_size = var.plan_sku
  plan_sku_tier = var.plan_sku_tier
  plan_kind     = var.plan_kind
  plan_reserved = var.plan_reserved

  resource_group_name = azurerm_resource_group.rg.name

  # Linux App Framework and version for the App Service.
  linux_fx_version = "${var.runtime_name}|${var.runtime_version}"

  app_settings = {
    JAVA_OPTS                          = var.java_opts
    LANG                               = var.system_encoding
    POSTGRES_CONNECTION_URL            = data.azurerm_key_vault_secret.postgres-connection-url.value
    POSTGRES_SERVER_ADMIN_FULL_NAME    = data.azurerm_key_vault_secret.postgres-server-admin.value
    POSTGRES_SERVER_ADMIN_PASSWORD     = data.azurerm_key_vault_secret.postgres-server-password.value
    "spring.config.location"           = var.spring_config_location
    WEBSITE_HTTPLOGGING_RETENTION_DAYS = var.http_log_retention_days
  }

  app_command_line = "/home/site/deployments/tools/startup_script.sh"

  tags = {
    environment = var.environment
  }
}


resource "azurerm_app_service_virtual_network_swift_connection" "swift" {
  depends_on     = [module.web_app, azurerm_subnet.subnet]
  app_service_id = module.web_app.id
  subnet_id      = azurerm_subnet.subnet.id
}
