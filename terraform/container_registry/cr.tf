# Generate random value for the name
resource "random_string" "name" {
  length  = 11
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Generate random value for the login password
resource "random_password" "password" {
  length           = 30
  lower            = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

resource "azurerm_container_registry" "cr_sample_app" {
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.cr_resource_group.name
  location            = azurerm_resource_group.cr_resource_group.location
  sku                 = "Standard"
  admin_enabled       = true
  admin_username      = random_string.name.result
  admin_password      = random_password.password.result
  tags                = var.tags
}
