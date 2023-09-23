terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "t-clo-907-lyo-3"
    storage_account_name = "atclo901lyo323092023"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
    use_oidc = true 
    features {}
}

resource "azurerm_resource_group" "resource_group_tfstate" {
  name     = var.az_resource_group_name
  location = var.az_location
}