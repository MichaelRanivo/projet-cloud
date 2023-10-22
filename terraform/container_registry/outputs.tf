output "admin_login" {
  value = azurerm_container_registry.cr_sample_app.admin_username
}

output "admin_password" {
  sensitive = true
  value     = azurerm_container_registry.cr_sample_app.admin_password
}