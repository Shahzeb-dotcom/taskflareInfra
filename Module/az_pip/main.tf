resource "azurerm_public_ip" "pip" {
  for_each = var.pips
  name     = each.value.pipname
  location = each.value.piplocation
  resource_group_name = each.value.rgname

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.common_tags

  # lifecycle {
  #   prevent_destroy = true
  #   ignore_changes = [
  #     tags,  # Ignore changes to the tags attribute
  #   ]        # Prevent accidental deletion of the public IP
  # }
}