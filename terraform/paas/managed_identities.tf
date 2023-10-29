resource "azurerm_user_assigned_identity" "identity_paas" {
  name                = var.assigned_identity_name
  resource_group_name = azurerm_resource_group.paas_resource_group.name
  location            = azurerm_resource_group.paas_resource_group.location
}