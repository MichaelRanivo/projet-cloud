terraform {
  required_version = ">=0.12"
  required_providers {

    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }

  }
}

provider "azapi" {}

provider "azurerm" {
  features {}
}