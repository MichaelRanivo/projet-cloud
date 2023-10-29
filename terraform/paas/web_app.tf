resource "azurerm_service_plan" "paas_web_app_plan" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.paas_resource_group.name
  location            = azurerm_resource_group.paas_resource_group.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "paas_web_app" {
    name                = var.web_app_name
    location            = azurerm_resource_group.paas_resource_group.location
    resource_group_name = azurerm_resource_group.paas_resource_group.name
    service_plan_id     = azurerm_service_plan.paas_web_app_plan.id

    app_settings = {
        DOCKER_ENABLE_CI                    = true
        WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
        WEBSITES_PORT                       = var.sample_app_port
    }

    site_config {
        always_on                                       = "true"
        container_registry_use_managed_identity         = true
        container_registry_managed_identity_client_id   = azurerm_user_assigned_identity.identity_paas.client_id
        application_stack {
            docker_image_name           = "${var.sample_app_docker_image_name}:latest"
            docker_registry_url         = "https://${data.azurerm_container_registry.app_container_registry.login_server}"
            docker_registry_username    = data.azurerm_container_registry.app_container_registry.admin_username
            docker_registry_password    = data.azurerm_container_registry.app_container_registry.admin_password
        }
    }

    identity {
        type            = "UserAssigned"
        identity_ids    = [azurerm_user_assigned_identity.identity_paas.id]
    }

    tags = var.tags
}