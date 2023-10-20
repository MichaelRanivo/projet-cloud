terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.50"
    }
  }
}
 
provider "azurerm" {
  features {}
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}
 
resource "azurerm_resource_group" "tfstate_storage_resource_group" {
  name      = var.backend_resource_group_name
  location  = var.azure_cloud_location
  tags      = var.tags
} 

resource "azurerm_storage_account" "tfstate_storage_account" {
  name                            = join("",[var.backend_storage_account_name,random_string.resource_code.result])
  resource_group_name             = azurerm_resource_group.tfstate_storage_resource_group.name
  location                        = azurerm_resource_group.tfstate_storage_resource_group.location
  account_tier                    = var.storage_account_tier
  account_replication_type        = var.storage_account_replication_type
  allow_nested_items_to_be_public = false
  tags                            = var.tags
}

resource "azurerm_storage_container" "tfstate_storage_container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.tfstate_storage_account.name
  container_access_type = var.storage_container_access_type
}