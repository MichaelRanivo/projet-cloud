variable "resource_group_db_name" {
    type        = string
    description = "The name of the resource group where we build our db"
}

variable "resource_group_location" {
    type        = string
    description = "The location of the resource group"
}

variable "tags" {
    type        = map(string)
    description = "Informations who will tag all resources"
}