resource "azurerm_network_security_group" "example" {
    for_each = var.nsg
  name                = each.value.nsgname
  location            = each.value.nsglocation
  resource_group_name = each.value.rgname

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}