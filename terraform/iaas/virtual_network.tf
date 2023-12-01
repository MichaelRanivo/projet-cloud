# Create virtual network
resource "azurerm_virtual_network" "iaas-vnet" {
  name                = var.iaas_vnet_name
  location            = azurerm_resource_group.iaas_resource_group.location
  resource_group_name = azurerm_resource_group.iaas_resource_group.name
  address_space       = ["10.0.0.0/16"]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]
  tags                = var.tags
  depends_on          = [ azurerm_resource_group.iaas_resource_group ]
}

# Create subnet
resource "azurerm_subnet" "iaas_subnet" {
  name                  = var.iaad_subnet_name
  resource_group_name   = azurerm_resource_group.iaas_resource_group.name
  virtual_network_name  = azurerm_virtual_network.iaas-vnet.name
  address_prefixes      = ["10.0.2.0/24"]
  depends_on            = [ azurerm_resource_group.iaas_resource_group ]
}