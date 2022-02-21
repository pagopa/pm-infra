terraform {
  required_version = ">= 0.14.5"
  backend "azurerm" {
    resource_group_name  = "U87-tf-infra-rg-pci-uat"
    storage_account_name = "pminfrastterraformuatpci"
    container_name       = "azurestate"
    key                  = "pm-iac-projects.terraform.tfstate"
  }
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "= 0.1.4"
    }
    azurerm = {
      version = "~> 2.52.0"
    }
  }
}

provider "azurerm" {
  features {}
}
