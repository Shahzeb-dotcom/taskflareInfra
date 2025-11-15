data "azurerm_subnet" "subnet" {
    for_each = var.vms
    name     = each.value.subnet_name
    virtual_network_name = each.value.vnet_name
    resource_group_name = each.value.rgname
}
resource "azurerm_network_interface" "nic" {
    for_each = var.vms
    name     = each.value.nicname
    location = each.value.vmlocation
    resource_group_name = each.value.rgname
    
    ip_configuration {
        name                          = each.value.ipconfig_name
        subnet_id                     = data.azurerm_subnet.subnet[each.key].id
        private_ip_address_allocation = "Dynamic"
        
    }
    
    tags = var.common_tags

}

resource "azurerm_virtual_machine" "vm" {
  for_each = var.vms
  name                  = each.value.vmname
    location              = each.value.vmlocation
    resource_group_name   = each.value.rgname
    network_interface_ids = [azurerm_network_interface.nic[each.key].id]
    vm_size               = each.value.vmsize
    delete_os_disk_on_termination = true
    delete_data_disks_on_termination = true
    storage_image_reference {
        publisher = each.value.image_publisher
        offer     = each.value.image_offer
        sku       = each.value.image_sku
        version   = each.value.image_version
    }
    storage_os_disk {
        name              = each.value.osdisk_name
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    os_profile {
        computer_name  = each.value.osprofile_computername
        admin_username = each.value.osprofile_adminusername
        admin_password = each.value.osprofile_adminpassword
    }
    os_profile_linux_config {
    disable_password_authentication = false
  }
    
    
    }



