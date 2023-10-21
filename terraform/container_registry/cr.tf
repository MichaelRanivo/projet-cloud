resource "azurerm_container_registry" "cr_sample_app" {
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.cr_resource_group.name
  location            = azurerm_resource_group.cr_resource_group.location
  sku                 = "Standard"
  admin_enabled       = true
  tags                = var.tags
}
