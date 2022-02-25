resource "azurerm_resource_group" "vnet" {
  name     = var.network_resource
  location = var.location

  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard,
    TS_Code    = var.tsi,
    CreatedBy = "Terraform"
  }
}

resource "azurerm_virtual_network" "vnet-inbound" {
  name                = var.vnet_inbound_name
  address_space       = [data.azurerm_key_vault_secret.vnet-inbound-address-space.value]
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet.name

  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard,
    TS_Code    = var.tsi,
    CreatedBy = "Terraform"
  }
}

resource "azurerm_subnet" "inbound-default" {
  name                                           = "default"
  enforce_private_link_endpoint_network_policies = "true"
  resource_group_name                            = azurerm_resource_group.vnet.name
  virtual_network_name                           = azurerm_virtual_network.vnet-inbound.name
  address_prefixes                               = [data.azurerm_key_vault_secret.vnet-inbound-address-space.value]
}

resource "azurerm_virtual_network" "vnet-outgoing" {
  name                = var.vnet_outgoing_name
  address_space       = [data.azurerm_key_vault_secret.vnet-outgoing-address-space.value]
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet.name

  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard,
    TS_Code    = var.tsi,
    CreatedBy = "Terraform"
  }
}

resource "azurerm_virtual_network" "vnet-database" {
  name                = var.vnet_database_name
  address_space       = [data.azurerm_key_vault_secret.vnet-database-address-space.value]
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet.name

  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard,
    TS_Code    = var.tsi,
    CreatedBy = "Terraform"
  }
}