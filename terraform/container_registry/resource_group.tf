resource "azurerm_resource_group" "cr_resource_group" {
  name      = var.resource_group_container_registry
  location  = var.resource_group_location
  tags      = var.tags
}