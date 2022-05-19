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
      version = ">=0.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.52.0"
    }
  }
}


provider "azurerm" {
  features {}
}

provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/sia-dds"
  personal_access_token = "64q3wfgx34yya7ggxzo47s2mp3np7qu2bclbh5rtsqtzxgyv7vfa"
}
