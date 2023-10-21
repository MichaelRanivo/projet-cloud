# Generate random value for the name
resource "random_string" "name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Generate random value for the login password
resource "random_password" "password" {
  length           = 30
  lower            = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

# Manages the MySQL Flexible Server
resource "azurerm_mysql_flexible_server" "app_db_server" {
    resource_group_name             = azurerm_resource_group.db_resource_group.name
    name                            = lower(join("", [var.database_server_name,random_string.name.result]))
    location                        = azurerm_resource_group.db_resource_group.location
    version                         = "8.0.21"
    #   workload_type 

    sku_name                        = var.database_sku
    storage {
        size_gb             = 20
        io_scaling_enabled  = true
    }
    backup_retention_days           = 7
    geo_redundant_backup_enabled    = false

    zone                            = "3"
    administrator_login             = random_string.name.result
    administrator_password          = random_password.password.result

    # public_network_access_enabled   = true
    depends_on = [ azurerm_resource_group.db_resource_group ]
}

# Manage the Firewall rule for the MySQL Flexible Server
resource "azurerm_mysql_flexible_server_firewall_rule" "db_server_firewall_rule" {
  name                = "firewall_rule"
  resource_group_name = azurerm_resource_group.db_resource_group.name
  server_name         = azurerm_mysql_flexible_server.app_db_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"

  depends_on = [ azurerm_resource_group.db_resource_group, azurerm_mysql_flexible_server.app_db_server ]
}

# Manages the MySQL Flexible Server Database
resource "azurerm_mysql_flexible_database" "app_db" {
    charset             = "utf8mb4"
    collation           = "utf8mb4_0900_ai_ci"
    name                = var.database_name
    resource_group_name = azurerm_resource_group.db_resource_group.name
    server_name         = azurerm_mysql_flexible_server.app_db_server.name
}