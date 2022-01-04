terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {}
}
provider "azurerm" {
  features {}
}

#data "azurerm_resource_group" "rg" {
#  name = var.rg
#}