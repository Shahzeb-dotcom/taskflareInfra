resource "azurerm_resource_group" "name" {
    for_each = var.rgs
  # Create a resource group for each item in the rgs variable
  name =each.value.rgname
  location = each.value.rglocation
    tags = var.common_tags
    # # lifecycle {
    # #   prevent_destroy = true
    # #   create_before_destroy = false
    # #     ignore_changes = [
    # #         tags,  # Ignore changes to the tags attribute
    # #     ]        # Prevent accidental deletion of the resource group
    # }
}
