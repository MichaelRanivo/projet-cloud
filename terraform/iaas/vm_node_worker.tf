# Créer cette interface après le subnet et l'adresse 
# Create network interface
resource "azurerm_network_interface" "node_worker_nic" {
  count               = 3
  name                = "${var.net_int_node_worker_name}-${count.index}"
  location            = azurerm_resource_group.iaas_resource_group.location
  resource_group_name = azurerm_resource_group.iaas_resource_group.name

  ip_configuration {
    name                          = var.net_int_ip_config_worker_name
    subnet_id                     = azurerm_subnet.iaas_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [ 
    azurerm_subnet.iaas_subnet
  ]
}

# Créer arpès l'interface réseau en meme temps que l'ip public et le groupe de securité
# Create virtual machine
resource "azurerm_linux_virtual_machine" "node_worker_vm" {
  count                             = 3
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

  computer_name         = "worker"
  admin_username        = var.node_worker_username

  admin_ssh_key {
    username   = var.node_worker_username
    public_key = jsondecode(azapi_resource_action.node_worker_ssh_public_key_gen[count.index].output).publicKey
  }

  depends_on          = [ 
    azapi_resource_action.node_worker_ssh_public_key_gen,
    azurerm_subnet.iaas_subnet
  ]
}

# Créer en meme temps que la VM apres l'interface réseau
# Create Network Security Group and rule
resource "azurerm_network_security_group" "node_worker_sg" {
  name                = var.node_worker_network_sg_name
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
    name                       = "KubeletAPI"
    priority                   = 101
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
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "30000-32767"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [ azurerm_resource_group.iaas_resource_group ]
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "ni_node_worker_sg" {
  count                     = 3
  network_interface_id      = azurerm_network_interface.node_worker_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.node_worker_sg.id
}