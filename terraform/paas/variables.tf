variable "resource_group_container_registry" {
    type        = string
    description = "The name of the resource group where the container registry is" 
}

variable "container_registry_name" {
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

variable "aks-cluster-name" {
    type        = string
    description = "The name of the cluster AKS"
}

variable "aks-sku" {
    type        = string
    description = "The sku of the AKS"
}

variable "dns_aks_prefix" {
    type        = string
    description = "The DNS prefixe of the AKS"
}

variable "kube_version" {
    type        = string
    description = "The version of the Kubernetes"
}

variable "aks_auto_upgrade" {
    type        = string
    description = "The upgrade channel for this Kubernetes Cluster"
}

variable "aks_api_private" {
    type        = bool
    description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses?"
}

variable "tags" {
    type        = map(string)
    description = "Informations who will tag all resources"
}