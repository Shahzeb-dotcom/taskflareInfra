resource "azurerm_log_analytics_workspace" "example" {
    for_each = var.workspace
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rgname
  sku                 = "PerGB2018"
  retention_in_days   = 30
}