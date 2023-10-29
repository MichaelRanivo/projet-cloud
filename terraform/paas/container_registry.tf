data "azurerm_container_registry" "app_container_registry" {
  name                = var.data_container_registry_name
  resource_group_name = var.resource_group_container_registry
}

resource "azurerm_role_assignment" "registry_role_assignment" {
  scope                             = data.azurerm_container_registry.app_container_registry.id
  role_definition_name              = var.registry_role_definition_name
  principal_id                      = azurerm_user_assigned_identity.identity_paas.principal_id
  skip_service_principal_aad_check  = true
}