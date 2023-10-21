variable "resource_group_container_registry" {
    type        = string
    description = "The name of the resource group of the container registry"
}

variable "resource_group_location" {
    type        = string
    description = "The location of the resource group"
}

variable "container_registry_name" {
    type        = string
    description = "The name of the container registry"
}

variable "tags" {
    type        = map(string)
    description = "Informations who will tag all resources"
}