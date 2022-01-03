data "azurerm_resource_group" "rg_vnet" {
  name = var.network_resource
}

data "azurerm_virtual_network" "vnet_outgoing" {
  name                = var.vnet_outgoing_name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

#resource "azurerm_subnet" "subnet" {
#  name                 = format("%s-%s", var.subnet_name, var.environment)
#  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
#  virtual_network_name = data.azurerm_virtual_network.vnet_outgoing.name
#  address_prefixes     = [data.azurerm_key_vault_secret.outgoing-subnet-address-space.value]
#  delegation {
#    name = "Microsoft.Web.serverFarms"
#
#    service_delegation {
#      actions = [
#        "Microsoft.Network/virtualNetworks/subnets/action",
#      ]
#      name = "Microsoft.Web/serverFarms"
#    }
#  }
#}

data "azurerm_virtual_network" "vnet_inbound" {
  name                = var.vnet_inbound_name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_subnet" "inboundsubnet" {
  name                 = var.inboundsubnet_name
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = var.vnet_inbound_name
}
