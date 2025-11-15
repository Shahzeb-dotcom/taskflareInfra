output "vnet_ids" {
  value = { for k, v in azurerm_virtual_network.vnetsubnet : k => v.id }
}
