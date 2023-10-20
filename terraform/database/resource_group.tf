resource "azurerm_resource_group" "db_resource_group" {
  name      = var.resource_group_db_name
  location  = var.resource_group_location
  tags      = var.tags
}