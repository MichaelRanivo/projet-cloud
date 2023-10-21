output "db_server_name" {
  value = azurerm_mysql_flexible_server.app_db_server.name
}

output "admin_login" {
  value = azurerm_mysql_flexible_server.app_db_server.administrator_login
}

output "admin_password" {
  sensitive = true
  value     = azurerm_mysql_flexible_server.app_db_server.administrator_password
}