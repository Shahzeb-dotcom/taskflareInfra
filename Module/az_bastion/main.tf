data "azurerm_subnet" "subnet" {
    for_each = var.bastion
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rgname
  
}
data "azurerm_public_ip" "pip" {
    for_each = var.bastion
  name                = each.value.pipname
  resource_group_name = each.value.rgname
}
resource "azurerm_bastion_host" "bastion" {
    for_each = var.bastion
  name                = each.value.bastionname
  location            = each.value.bastionlocation
  resource_group_name = each.value.rgname
lifecycle {
  prevent_destroy = false
}
  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
  }
}