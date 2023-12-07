# Créer Avant la VM node Master
resource "azapi_resource_action" "ssh_public_key_gen" {
  type                      = var.node_ssh_public_key_type
  resource_id               = azapi_resource.ssh_public_key.id
  action                    = "generateKeyPair"
  method                    = "POST"
  response_export_values    = ["publicKey", "privateKey"]
  depends_on                = [ azapi_resource.ssh_public_key ]
}

resource "azapi_resource" "ssh_public_key" {
  type        = var.node_ssh_public_key_type
  name        = var.node_ssh_public_key_name
  location    = var.resource_group_location
  parent_id   = azurerm_resource_group.iaas_resource_group.id
  depends_on  = [ azurerm_resource_group.iaas_resource_group ]
}
