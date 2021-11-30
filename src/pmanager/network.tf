data "azurerm_resource_group" "rg_vnet" {
  name = var.network_resource
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

resource "azurerm_subnet" "subnet" {
  name                 = format("%s-%s", var.subnet_name, var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = [data.azurerm_key_vault_secret.outgoing-subnet-address-space.value]
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

resource "azurerm_subnet" "endpointsubnet" {
  name                                           = format("%s-%s", var.endpointsubnet_name, var.environment)
  resource_group_name                            = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = var.vnet_name
  address_prefixes                               = [data.azurerm_key_vault_secret.endpointsubnet-address-space.value]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_private_endpoint" "inbound-endpt" {
  depends_on          = [module.web_app]
  name                = format("%s-inbound-endpt", module.web_app.name)
  location            = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  subnet_id           = azurerm_subnet.endpointsubnet.id


  private_service_connection {
    name                           = format("%s-privateserviceconnection", var.name)
    private_connection_resource_id = module.web_app.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }
  tags = {
    environment = var.environment
  }
}
