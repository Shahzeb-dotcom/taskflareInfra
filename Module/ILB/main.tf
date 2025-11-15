resource "azurerm_lb" "ilb" {
  for_each            = var.ilbs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rgname
  sku                 = each.value.lb_sku

  frontend_ip_configuration {
    name                          = each.value.frontend_name
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = each.value.private_ip_allocation
  }
}

resource "azurerm_lb_backend_address_pool" "pool" {
  for_each            = var.ilbs
  loadbalancer_id     = azurerm_lb.ilb[each.key].id
  name                = each.value.backend_pool_name
}

resource "azurerm_lb_probe" "probe" {
  for_each            = var.ilbs
  loadbalancer_id     = azurerm_lb.ilb[each.key].id
  name                = each.value.probe_name
  protocol            = "Tcp"
  port                = each.value.probe_port
}

resource "azurerm_lb_rule" "rule" {
  for_each                        = var.ilbs
  name                            = each.value.lb_rule_name
  loadbalancer_id                 = azurerm_lb.ilb[each.key].id
  protocol                        = each.value.protocol
  frontend_port                   = each.value.frontend_port
  backend_port                    = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_name
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.pool[each.key].id]
  probe_id                        = azurerm_lb_probe.probe[each.key].id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc" {
  for_each = var.ilbs

  network_interface_id    = data.azurerm_network_interface.nic[each.key].id
  ip_configuration_name   = each.value.ipconfig_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.pool[each.key].id
}

# Supporting data blocks
data "azurerm_subnet" "subnet" {
  for_each             = var.ilbs
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rgname
}

data "azurerm_network_interface" "nic" {
  for_each            = var.ilbs
  name                = each.value.nic_name
  resource_group_name = each.value.rgname
}
