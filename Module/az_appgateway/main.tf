# Module: az_appgw/main.tf
data "azurerm_subnet" "subnet" {
  for_each = var.appgws
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rgname
}
data "azurerm_public_ip" "pip" {
  for_each = var.appgws
  name                 = each.value.pip_name
  resource_group_name  = each.value.rgname
}

resource "azurerm_application_gateway" "appgw" {
  for_each            = var.appgws
  name                = each.value.appgwname
  location            = each.value.location
  resource_group_name = each.value.rgname

  sku {
    name     = each.value.skuname
    tier     = each.value.skutier
    capacity = each.value.skucapacity
  }

  gateway_ip_configuration {
    name      = each.value.gateway_ip_config_name
    subnet_id = data.azurerm_subnet.subnet[each.key].id
  }

  frontend_port {
    name = each.value.frontend_portname
    port = each.value.frontend_port
  }

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_name
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
  }

  backend_address_pool {
    name  = each.value.backend_pool_name
    ip_addresses = each.value.backend_ip_addresses
  }

  backend_http_settings {
    name                  = each.value.backend_http_setting_name
    cookie_based_affinity = each.value.backend_http_settingscookie_based_affinity
    port                  = each.value.backend_http_settingsport
    protocol              = each.value.backend_http_settingsprotocol
    request_timeout       = each.value.backend_http_settingsrequest_timeout
  }

  http_listener {
    name                           = each.value.http_listenername
    frontend_ip_configuration_name = each.value.http_listenerfrontend_ip_configuration_name
    frontend_port_name             = each.value.http_listenerfrontend_port_name
    protocol                       = each.value.http_listenerprotocol
  }

  request_routing_rule {
    name                       = each.value.request_routing_rulename
    rule_type                  = each.value.request_routing_rulerule_type
    http_listener_name         = each.value.request_routing_rulehttp_listener_name
    backend_address_pool_name  = each.value.request_routing_rulebackend_address_pool_name
    backend_http_settings_name = each.value.request_routing_rulebackend_http_settings_name
    priority = each.value.request_routing_rulepriority
  }

}
