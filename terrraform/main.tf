
locals {
  first_public_key = "ssh-rsa 
AAAAB3NzaC1yc2EAAAADAQABAAABAQC+wWK73dCr+jgQOAxNsHAnNNNMEMWOHYEccp6wJm2gotpr9katuF/ZAdou5AaW1C61slRkHRkpRRX9FA9CYBiitZgvCCz+3nWNN7l/Up54Zps/pHWGZLHNJZRYyAB6j5yVLMVHIHriY49d/GZTZVNB8GoJv9Gakwc/fuEZYYl4YDFiGMBP///TzlI4jhiJzjKnEvqPFki5p2ZRJqcbCiF4pJrxUQR/RXqVFQdbRLZgYfJ8xGB878RENq3yQ39d8dVOkq4edbkzwcUmwwwkYVPIoDGsYLaRHnG+To7FvMeyO7xDVQkMKzopTQV8AuKpyvpqu0a9pWOMaiCyDytO7GGN 
you@me.com"
}


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terracloud" {
  name     = "terracloud"
  location = "West Europe"
}

resource "azurerm_virtual_network" "terracloud_vpc" {
  name                = "terracloud-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.terracloud.location
  resource_group_name = azurerm_resource_group.terracloud.name
}

resource "azurerm_subnet" "terracloud_network" {
  name                 = "terracloud_vpc"
  resource_group_name  = azurerm_resource_group.terracloud.name
  virtual_network_name = azurerm_virtual_network.terracloud_vpc.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "terracloud_ip" {
  name                = "terracloud-public-ip"
  location            = azurerm_resource_group.terracloud.location
  resource_group_name = azurerm_resource_group.terracloud.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "terracloud_lb" {
  name                = "terracloud-lb"
  location            = azurerm_resource_group.terracloud.location
  resource_group_name = azurerm_resource_group.terracloud.name
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.terracloud_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "terracloud_backend_pool" {
  name                = "terracloud-backend-pool"
  loadbalancer_id     = azurerm_lb.terracloud_lb.id
}

resource "azurerm_network_interface" "terracloud_nic" {
  name                = "terracloud-nic"
  location            = azurerm_resource_group.terracloud.location
  resource_group_name = azurerm_resource_group.terracloud.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.terracloud_network.id
    private_ip_address_allocation = "Dynamic"
  }
}



resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                = "example-vmss"
  resource_group_name = azurerm_resource_group.terracloud.name
  location            = azurerm_resource_group.terracloud.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = local.first_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.terracloud_network.id
    }
  }
}

