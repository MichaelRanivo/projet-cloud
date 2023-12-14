# Generate random value for the name
resource "random_string" "name" {
  length  = 5
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_container_registry" "cr_sample_app" {
  name                = lower(join("", [var.container_registry_name,random_string.name.result]))
  resource_group_name = azurerm_resource_group.cr_resource_group.name
  location            = azurerm_resource_group.cr_resource_group.location
  sku                 = "Standard"
  admin_enabled       = true
  tags                = var.tags
}
 