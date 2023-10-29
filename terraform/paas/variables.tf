variable "resource_group_container_registry" {
    type        = string
    description = "The name of the resource group where is the Container Registry"
}

variable "data_container_registry_name" {
    type        = string
    description = "The name of the container registry"
}

variable "paas_resource_group_name" {
    type        = string
    description = "The name of the resource group where we deploy the paas"
}

variable "resource_group_location" {
    type        = string
    description = "The Azure Cloud's location for our infra"
}

variable "assigned_identity_name" {
    type        = string
    description = "The name of the managed identity"
}

variable "registry_role_definition_name" {
    type        = string
    description = "The name of the role"
}

variable "app_service_plan_name" {
    type        = string
    description = "The name of the app service plan"
}

variable "web_app_name" {
    type        = string
    description = "The name of the Azure Web app"
}

variable "sample_app_port" {
    type        = number
    description = "The Port of the app"
    default     = 80
}

variable "sample_app_docker_image_name" {
    type = string
    description = "The Docker image of the App"
}

variable "tags" {
    type        = map(string)
    description = "Informations who will tag all resources"
}