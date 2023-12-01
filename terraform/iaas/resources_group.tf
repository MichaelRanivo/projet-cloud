resource "azurerm_resource_group" "iaas_resource_group" {
  name      = var.iaas_resource_group_name
  location  = var.resource_group_location
  tags      = var.tags
}