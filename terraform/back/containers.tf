terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
    features {}
}

data "azurerm_resource_group" "resource_group_TCLO_901" {
  name = var.az_resource_group_name
}

output "id" {
  value = data.azurerm_resource_group.resource_group_TCLO_901.id
}

#Je prends les datas du resources groupe puis les datas du compte de stockage
#Après ça je crée une encryption puis je crée un containers a l'aide de l'encryption