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

    # subscription_id   = var.ARM_SUBSCRIPTION_ID
    # tenant_id         = var.ARM_TENANT_ID
    # client_id         = var.ARM_CLIENT_ID
    # client_secret     = var.ARM_CLIENT_SECRET
}

data "azurerm_resource_group" "resource_group_TCLO_901" {
  name = var.az_resource_group_name
}

output "id" {
  value = data.azurerm_resource_group.resource_group_TCLO_901.id
}

#Je prends les datas du resources groupe puis les datas du compte de stockage
#Après ça je crée une encryption puis je crée un containers a l'aide de l'encryption


# export TF_VAR_ARM_SUBSCRIPTION_ID=1eb5e572-df10-47a3-977e-b0ec272641e4
# export TF_VAR_ARM_TENANT_ID=901cb4ca-b862-4029-9306-e5cd0f6d9f86
# export TF_VAR_ARM_CLIENT_ID=411c7b5b-bce3-4bfe-b403-1bba4b319e0d
# export TF_VAR_ARM_CLIENT_SECRET=yb-8Q~2JzaMqY5p1HAQEwBAmbmgpEyd_.N3YXbEK