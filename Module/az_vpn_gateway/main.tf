data "azurerm_public_ip" "pip" {
  for_each = var.vpns2s
  name                = each.value.pip_name
  resource_group_name = each.value.rgname
}
data "azurerm_subnet" "subnet" {
  for_each = var.vpns2s
  name                 = each.value.subnet_name
  resource_group_name  = each.value.rgname
  virtual_network_name = each.value.vnet_name
}

resource "azurerm_local_network_gateway" "onpremise" {
  for_each = var.vpns2s
  name                = each.value.local_network_name
  location            = each.value.location
  resource_group_name = each.value.rgname
  gateway_address     = "5.4.56.7"
  address_space       = ["192.168.1.0/24"]
  # Uncomment to enable BGP with on‑prem
# bgp_settings {
# asn = 65010
# bgp_peering_address = "172.16.255.254" # on‑prem VPN BGP IP
# peer_weight = 0
# }
}

resource "azurerm_virtual_network_gateway" "vpn_gw" {
  for_each = var.vpns2s
  name                = each.value.vpn_gw_name
  location            = each.value.location
  resource_group_name = each.value.rgname

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    public_ip_address_id          = data.azurerm_public_ip.pip[each.key].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
  }
}

resource "azurerm_virtual_network_gateway_connection" "onpremise" {
  for_each = var.vpns2s
  name                = each.value.connection_name
  location            = each.value.location
  resource_group_name = each.value.rgname

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gw[each.key].id
  local_network_gateway_id   = azurerm_local_network_gateway.onpremise[each.key].id

  shared_key = "Azure@123"
}