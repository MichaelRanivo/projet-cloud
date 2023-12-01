variable "iaas_resource_group_name" {
    type        = string
    description = "The name of the resource group where we deploy the paas"
}

variable "resource_group_location" {
    type        = string
    description = "The Azure Cloud's location for our infra"
}

variable "iaas_vnet_name" {
    type        = string
    description = "The name of the virtual network for the iaas"
}

variable "iaad_subnet_name" {
    type        = string
    description = "The name of the subnet network for the iaas"
}

variable "net_int_node_master_name" {
    type        = string
    description = "The network interface for the Node Master"
}   

variable "net_int_ip_config_name" {
    type        = string
    description = "The name of the configuration ip of the network interface"
}

variable "vm_node_master_name" {
    type        = string
    description = "The name of the VM node master"
}  

variable "vm_node_master_size" {
    type        = string
    description = "The size of the Node Master VM"
}

variable "vm_node_master_os_disk_name" {
    type        = string
    description = "The OS Disk name of the VM"  
}

variable "vm_node_master_image_pub" {
    type        = string  
    description = "The name of the image"
}

variable "vm_node_master_image_offer" {
    type        = string
    description = "The Version of the image" 
}

variable "vm_node_master_image_sku" {
    type        = string
    description = "The Version number of the image"
}

variable "vm_node_master_image_version" {
    type        = string
    description = "The version we use of the image"
}

variable "node_master_username" {
    type        = string
    description = "The user we create on the VM"
}

variable "node_master_ssh_public_key_type" {
    type        = string
    description = "The ssh type public key" 
}

variable "node_master_ssh_public_key_name" {
    type        = string
    description = "THe ssh public key name"  
}

variable "node_master_public_ip_name" {
    type        = string
    description = "The name of the Public IP of the Node Master"
} 

variable "node_master_network_sg_name" {
    type        = string
    description = "The name of the security group of the node master"  
}

variable "net_int_node_worker_name" {
    type        = string
    description = "The name of the network interface of a Node Worker"
}

variable "net_int_ip_config_worker_name" {
    type = string
    description = "The name of the ip configuration for the network interface"
}



variable "tags" {
    type        = map(string)
    description = "Informations who will tag all resources"
}