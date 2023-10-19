variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "vnet_name" {
    type        = string
    description = "The name of the virtual network"
}

variable "vnet_ip_addr" {
    type = list(string)
    description = "The IP address of the Vnet"
}

variable "subnet_name" {
    type        = string
    description = "The subnet name"
}

variable "subnet_ip_addr" {
    type        =  list(string)
    description = "The subnet IP addresse"
}

variable "public_ip_name" {
    type        = string
    description = "The name of the Public IP"
}

variable "network_sg_r_name" {
    type        = string
    description = "The name of the network security group and rule"
}

variable "net_interface_name" {
    type        = string
    description = "The network interface's name"
}

variable "net_inter_ip_config_name" {
    type        = string
    description = "The IP config name of the network interface"
}

variable "vm_name" {
    type        = string
    description = "The name of the Virtual Machine" 
}

variable "vm_size" {
    type = string
    description = "The size of the VM"
}

variable "vm_os_disk_name" {
    type        = string
    description = "The os disk for the VM"
}

variable "vm_image_pub" {
    type        = string
    description = "The publisher of the vm image"
}

variable "vm_image_offer" {
    type        = string
    description = "The product ID of the vm image"
}

variable "vm_image_sku" {
    type        = string
    description = "The plan ID of the vm image"
}

variable "vm_image_version" {
    type        = string
    description = "The version of the vm image" 
}

variable "ssh_publick_key_type" {
    type        = string
    description = "The Microsoft endpoint to gen SSH public key" 
}

variable "ssh_public_key_name" {
    type        = string
    description = "The SSH public key name"
}

variable "username" {
    type        = string
    description = "The username for the local account that will be created on the new VM."
}