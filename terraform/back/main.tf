terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.50"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstateresourcegroup"
    storage_account_name = "tfstatestorageterra"
    container_name       = "tfstatestoragecontainer"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}