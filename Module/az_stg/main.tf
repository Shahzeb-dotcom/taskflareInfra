resource "azurerm_storage_account" "stg" {
    for_each = var.stgs
  name =each.value.stgname
  location = each.value.stglocation
    resource_group_name = each.value.rgname
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
    tags = var.common_tags
    
}