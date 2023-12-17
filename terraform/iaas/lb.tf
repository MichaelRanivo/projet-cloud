resource "azurerm_lb" "iaas-lb" {
  name                = var.iaas_lb_name
  resource_group_name = azurerm_resource_group.iaas_resource_group.name
  location            = azurerm_resource_group.iaas_resource_group.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.iaas_lb_Public_IP_Address_name
    public_ip_address_id = data.azurerm_public_ip.lb-adress-ip.id
  }

  sku_tier            = "Regional"
  tags                = var.tags
}

## Backend pools
resource "azurerm_lb_backend_address_pool" "lb-backend-pool" {
  name            = var.iaas_lb_backend_pool_name
  loadbalancer_id = azurerm_lb.iaas-lb.id
}

## add Network Interfaces to the Backend pools
resource "azurerm_network_interface_backend_address_pool_association" "add-master-node-backend-pool" {
  ip_configuration_name   = var.net_int_ip_config_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-backend-pool.id
  network_interface_id    = azurerm_network_interface.node_master_nic.id
}

resource "azurerm_network_interface_backend_address_pool_association" "add-worker-node-backend-pool" {
  count                   = var.nomber_of_vm_worker
  ip_configuration_name   = "${var.net_int_ip_config_worker_name}-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-backend-pool.id
  network_interface_id    = azurerm_network_interface.node_worker_nic[count.index].id
}

## Health probe
resource "azurerm_lb_probe" "healt-probe" {
  name                = var.iaas_lb_probe_name
  loadbalancer_id     = azurerm_lb.iaas-lb.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
}

## Load Balancer rules
resource "azurerm_lb_rule" "http_rules" {
  name                            = var.iaas_lb_rule_80_name
  loadbalancer_id                 = azurerm_lb.iaas-lb.id
  frontend_ip_configuration_name  = var.iaas_lb_Public_IP_Address_name
  backend_address_pool_ids        = [ azurerm_lb_backend_address_pool.lb-backend-pool.id ]
  protocol                        = "Tcp"
  frontend_port                   = 80
  backend_port                    = 80
  probe_id                        = azurerm_lb_probe.healt-probe.id
  load_distribution               = "SourceIPProtocol"
  idle_timeout_in_minutes         = 20
  enable_tcp_reset                = true
  disable_outbound_snat           = true
}

resource "azurerm_lb_rule" "https_rules" {
  name                            = var.iaas_lb_rule_443_name
  loadbalancer_id                 = azurerm_lb.iaas-lb.id
  frontend_ip_configuration_name  = var.iaas_lb_Public_IP_Address_name
  backend_address_pool_ids        = [ azurerm_lb_backend_address_pool.lb-backend-pool.id ]
  protocol                        = "Tcp"
  frontend_port                   = 443
  backend_port                    = 443
  probe_id                        = azurerm_lb_probe.healt-probe.id
  load_distribution               = "SourceIPProtocol"
  idle_timeout_in_minutes         = 20
  enable_tcp_reset                = true
  disable_outbound_snat           = true
}

## Inbound NAT rule
resource "azurerm_lb_nat_rule" "iaas_lb_nat_rules" {
  name                            = var.iaas_lb_nat_rule_name
  resource_group_name             = azurerm_resource_group.iaas_resource_group.name
  loadbalancer_id                 = azurerm_lb.iaas-lb.id
  backend_address_pool_id         = azurerm_lb_backend_address_pool.lb-backend-pool.id
  frontend_ip_configuration_name  = var.iaas_lb_Public_IP_Address_name
  protocol                        = "Tcp"
  frontend_port_start             = 500
  frontend_port_end               = 503
  backend_port                    = 22
  enable_tcp_reset                = true
  idle_timeout_in_minutes         = 20
}

## Outbound LB rules
resource "azurerm_lb_outbound_rule" "outbound_lb_rules" {
  name                    = "OutboundRule"
  loadbalancer_id         = azurerm_lb.iaas-lb.id

  frontend_ip_configuration {
    name = var.iaas_lb_Public_IP_Address_name
  }

  protocol                = "All"
  idle_timeout_in_minutes = 15
  enable_tcp_reset        = true
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-backend-pool.id
}