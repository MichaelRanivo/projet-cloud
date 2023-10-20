terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.50"
    }
  }
  backend "azurerm" {
    key                  = "db.tfstate"
    region               = "northeurope"
  }

}

provider "azurerm" {
  features {}
}