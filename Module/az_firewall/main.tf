data "azurerm_subnet" "subnet" {
  for_each = var.firewall
  name                 = each.value.subnet_name
  resource_group_name  = each.value.rgname
  virtual_network_name = each.value.vnet_name
}
data "azurerm_public_ip" "pip" {
  for_each = var.firewall
  name                = each.value.public_ip_name
  resource_group_name = each.value.rgname
}

resource "azurerm_firewall" "firewall" {
    for_each = var.firewall
  name                = each.value.firewall_name
  location            = each.value.location
  resource_group_name = each.value.rgname
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
  }
}