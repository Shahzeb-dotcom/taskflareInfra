resource "azurerm_mssql_server" "sql" {
    for_each = var.sql
    name                         = each.value.sqlname
    resource_group_name          = each.value.rgname
    location                     = each.value.sqllocation
    version                      = "12.0"
    administrator_login          = each.value.sqladminlogin
    administrator_login_password = each.value.sqladminpassword
    
   
}
resource "azurerm_mssql_database" "sqldb" {
    for_each = var.sql
  name         = each.value.sqldbname
  server_id    = azurerm_mssql_server.sql[each.key].id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  lifecycle {
    prevent_destroy = true
  
}
}