resource "azurerm_container_registry" "name" {
  for_each = var.acr
  name                = each.value.acrname         # Replace with your desired ACR name
  location            = each.value.location          # Replace with your Azure region
  resource_group_name = each.value.rgname    # Replace with your resource group name
  sku                 = "Basic"               # Choose from Basic, Standard, Premium
  admin_enabled       = false               # Set to true if you want to enable admin user
}