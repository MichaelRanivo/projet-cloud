data "azurerm_container_registry" "rc-data" {
    name                = join("",[var.container_registry_name,"teakr"])
    resource_group_name = var.resource_group_container_registry 
}