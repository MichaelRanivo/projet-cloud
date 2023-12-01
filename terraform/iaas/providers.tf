terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.50"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
  }
  backend "azurerm" {
    key                  = "iaas.tfstate"
    region               = "northeurope"
  }
}

provider "azapi" {}

provider "azurerm" {
  features {}
}