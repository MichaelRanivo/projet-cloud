resource "azurerm_lb" "iaas-lb" {
  name                = "TestLoadBalancer"
  resource_group_name = azurerm_resource_group.iaas_resource_group.name
  location            = azurerm_resource_group.iaas_resource_group.location

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.lb-adress-ip.id
  }
}

resource "azurerm_lb_rule" "example" {
  name                           = "LBRule"
  loadbalancer_id                = azurerm_lb.iaas-lb.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
}

resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = azurerm_lb.iaas-lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_outbound_rule" "example" {
  loadbalancer_id         = azurerm_lb.iaas-lb.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
  name                    = "OutboundRule"
  protocol                = "Tcp"

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}