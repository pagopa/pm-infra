terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.75.0"
    }
  }
  backend "azurerm" {}
}


provider "azurerm" {
  features {}
}

#  PM resource group
# - APP services
# - Service Plan
data "azurerm_resource_group" "rg" {
  name = var.rg
}

data "azurerm_resource_group" "rg_zone" {
  name = var.private_link_dns_zone_rg
}

# Private DNS zone
data "azurerm_private_dns_zone" "zone" {
  name                = var.private_link_dns_zone
  resource_group_name = var.private_link_dns_zone_rg
}
