# Créer Avant la VM node Master
resource "azapi_resource" "ssh_public_key" {
  name        = var.node_master_ssh_public_key_name
  type        = var.node_master_ssh_public_key_type
  location    = var.resource_group_location
  parent_id   = azurerm_resource_group.iaas_resource_group.id
  depends_on  = [ azurerm_resource_group.iaas_resource_group ]
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type                      = var.node_master_ssh_public_key_type
  resource_id               = azapi_resource.ssh_public_key.id
  action                    = "generateKeyPair"
  method                    = "POST"
  response_export_values    = ["publicKey", "privateKey"]
  depends_on                = [ azapi_resource.ssh_public_key ]
}

# Create public IPs
resource "azurerm_public_ip" "node_master_vm_public_ip" {
  name                = var.node_master_public_ip_name
  location            = azurerm_resource_group.iaas_resource_group.location
  resource_group_name = azurerm_resource_group.iaas_resource_group.name
  allocation_method   = "Dynamic"
  depends_on          = [ azurerm_resource_group.iaas_resource_group ]
}

# Créer cette interface après le subnet et l'adresse 
# Create network interface
resource "azurerm_network_interface" "node_master_nic" {
  name                = var.net_int_node_master_name
  location            = azurerm_resource_group.iaas_resource_group.location
  resource_group_name = azurerm_resource_group.iaas_resource_group.name

  ip_configuration {
    name                          = var.net_int_ip_config_name
    subnet_id                     = azurerm_subnet.iaas_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.node_master_vm_public_ip.id
  }

  depends_on = [ 
    azurerm_subnet.iaas_subnet,
    azurerm_public_ip.node_master_vm_public_ip 
  ]
}

# Créer arpès l'interface réseau en meme temps que l'ip public et le groupe de securité
# Create virtual machine
resource "azurerm_linux_virtual_machine" "node_master_vm" {
  name                  = var.vm_node_master_name
  location              = azurerm_resource_group.iaas_resource_group.location
  resource_group_name   = azurerm_resource_group.iaas_resource_group.name
  network_interface_ids = [azurerm_network_interface.node_master_nic.id]
  size                  = var.vm_node_master_size

  os_disk {
    name                 = var.vm_node_master_os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.vm_node_master_image_pub
    offer     = var.vm_node_master_image_offer
    sku       = var.vm_node_master_image_sku
    version   = var.vm_node_master_image_version
  }

  computer_name         = "master"
  admin_username        = var.node_master_username

  admin_ssh_key {
    username   = var.node_master_username
    public_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
  }

  depends_on          = [ 
    azurerm_network_interface.node_master_nic,
    azapi_resource_action.ssh_public_key_gen,
    azurerm_subnet.iaas_subnet
  ]
}

# Créer en meme temps que la VM apres l'interface réseau
# Create Network Security Group and rule
resource "azurerm_network_security_group" "node_master_sg" {
  name                = var.node_master_network_sg_name
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
    name                       = "KubernetesAPIserver"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "etcdserverclientAPI"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2379-2380"
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
    name                       = "kubescheduler"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "10259"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "kubeControllerManager"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "10257"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [ azurerm_resource_group.iaas_resource_group ]
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "ni_sg" {
  network_interface_id      = azurerm_network_interface.node_master_nic.id
  network_security_group_id = azurerm_network_security_group.node_master_sg.id
}