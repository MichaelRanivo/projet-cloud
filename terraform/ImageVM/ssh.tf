data "azurerm_resource_group" "data_resource_group" {
  name = var.resource_group_name
}

resource "azapi_resource" "ssh_public_key" {
  type      = var.ssh_publick_key_type
  name      = var.ssh_public_key_name
  location  = var.resource_group_location
  parent_id = data.azurerm_resource_group.data_resource_group.id
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type                      = var.ssh_publick_key_type
  resource_id               = azapi_resource.ssh_public_key.id
  action                    = "generateKeyPair"
  method                    = "POST"
  response_export_values    = ["publicKey", "privateKey"]
}