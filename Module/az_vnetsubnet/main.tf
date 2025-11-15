resource "azurerm_virtual_network" "vnetsubnet" {
  for_each = var.vnets
  name     = each.value.vnetname
  location = each.value.vnetlocation
  resource_group_name = each.value.rgname
  address_space       = each.value.address_space

  tags = var.common_tags
  dynamic "subnet" {
    
    for_each = each.value.subnets 
       content {
      name           = subnet.value.subnetname
      address_prefixes = subnet.value.address_prefixes
    }
  }
}

