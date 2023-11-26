resource "azurerm_resource_group" "paas_resource_group" {
  name      = var.paas_resource_group_name
  location  = var.resource_group_location
  tags      = var.tags
}