variable "resource_group_db_name" {
    type        = string
    description = "The name of the resource group where we build our db"
}

variable "resource_group_location" {
    type        = string
    description = "The location of the resource group"
}

variable "database_name" {
    type        = string
    description = "The name of the database"
}

variable "database_server_name" {
    type        = string
    description = "The name of the database server"
}

variable "database_sku" {
    type        = string
    description = "The type of the server we will use for the database"
}

variable "tags" {
    type        = map(string)
    description = "Informations who will tag all resources"
}