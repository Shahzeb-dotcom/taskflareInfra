resource "azurerm_resource_group" "rg" {
  name = "test-rg"
  location = "east us"
}

resource "azurerm_virtual_network" "vnet"{
name = "test-vnet"
location = "east us"
resource_group_name = azurerm_resource_group.rg.name
address_space = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  name = "${each.key}-subnet"
  resource_group_name = azurerm_resource_group.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = ["10.0.${each.value}.0/24"]
}

# address_prefixes = ["10.0.${each.key == "frontend" ? 1 : each.key == "backend" ? 2 : 3}.0/24"]
