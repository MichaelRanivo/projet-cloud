# Créer en meme temps que la VM apres l'interface réseau
# Create Network Security Group and rule
resource "azurerm_network_security_group" "node_worker_sg" {
  count               = var.nomber_of_vm_worker
  name                = "${var.node_worker_network_sg_name}-${count.index}"
  location            = azurerm_resource_group.iaas_resource_group.location
  resource_group_name = azurerm_resource_group.iaas_resource_group.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "KubeletAPI"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "10250"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "NodePortService"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "30000-32767"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "CalicoNetworking"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "179"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "CalicoNetworkingWithVXLANEnabled"
    priority                   = 106
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "4789"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "CalicoNetworkingWithTyphaEnabled"
    priority                   = 107
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5473"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "CalicoNetworkingWithIPv4WireguardEnabled"
    priority                   = 108
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "51820"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "CalicoNetworkingWithIPv6WireguardEnabled"
    priority                   = 109
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "51821"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "CertmanagerMetrics"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9402"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "IngressController"
    priority                   = 111
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "IngressController"
    priority                   = 112
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "OutboundRule"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [ 
    azurerm_resource_group.iaas_resource_group,
    azurerm_subnet.iaas_subnet 
  ]
}

# Créer cette interface après le subnet et l'adresse 
# Create network interface
resource "azurerm_network_interface" "node_worker_nic" {
  count               = var.nomber_of_vm_worker
  name                = "${var.net_int_node_worker_name}-${count.index}"
  location            = azurerm_resource_group.iaas_resource_group.location
  resource_group_name = azurerm_resource_group.iaas_resource_group.name

  ip_configuration {
    name                          = "${var.net_int_ip_config_worker_name}-${count.index}"
    subnet_id                     = azurerm_subnet.iaas_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [ 
    azurerm_resource_group.iaas_resource_group,
    azurerm_subnet.iaas_subnet,
    azurerm_network_security_group.node_worker_sg[0],
    azurerm_network_security_group.node_worker_sg[1],
    azurerm_network_security_group.node_worker_sg[2],
  ]
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "ni_node_worker_sg" {
  count                     = var.nomber_of_vm_worker
  network_interface_id      = azurerm_network_interface.node_worker_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.node_worker_sg[count.index].id

  depends_on = [ 
    azurerm_resource_group.iaas_resource_group,
    azurerm_subnet.iaas_subnet,
    azurerm_network_security_group.node_worker_sg[0],
    azurerm_network_security_group.node_worker_sg[1],
    azurerm_network_security_group.node_worker_sg[2],
    azurerm_network_interface.node_worker_nic[0],
    azurerm_network_interface.node_worker_nic[1],
    azurerm_network_interface.node_worker_nic[2]
  ]
}

# Créer arpès l'interface réseau en meme temps que l'ip public et le groupe de securité
# Create virtual machine
resource "azurerm_linux_virtual_machine" "node_worker_vm" {
  count                             = var.nomber_of_vm_worker
  name                              = "${var.vm_node_worker_name}-${count.index}"
  location                          = azurerm_resource_group.iaas_resource_group.location
  resource_group_name               = azurerm_resource_group.iaas_resource_group.name
  network_interface_ids             = [azurerm_network_interface.node_worker_nic[count.index].id]
  size                              = var.vm_node_worker_size

  os_disk {
    name                 = "${var.vm_node_worker_os_disk_name}-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.vm_node_worker_image_pub
    offer     = var.vm_node_worker_image_offer
    sku       = var.vm_node_worker_image_sku
    version   = var.vm_node_worker_image_version
  }

  computer_name         = "${var.vm_node_worker_name}-${count.index}"
  admin_username        = var.node_worker_username

  admin_ssh_key {
    username   = var.node_worker_username
    public_key = jsondecode(azapi_resource_action.node_worker_ssh_public_key_gen[count.index].output).publicKey
  }

  depends_on          = [ 
    azurerm_resource_group.iaas_resource_group,
    azurerm_subnet.iaas_subnet,
    azurerm_network_interface_security_group_association.ni_node_worker_sg[0],
    azurerm_network_interface_security_group_association.ni_node_worker_sg[1],
    azurerm_network_interface_security_group_association.ni_node_worker_sg[2],
    azurerm_network_interface.node_worker_nic[0],
    azurerm_network_interface.node_worker_nic[1],
    azurerm_network_interface.node_worker_nic[2],
    azapi_resource_action.node_worker_ssh_public_key_gen
  ]
}