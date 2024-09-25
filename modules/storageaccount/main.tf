resource "azurerm_storage_account" "storageaccount" {
  name                = var.storageAccountName
  resource_group_name = var.resourceGroupName

  location                 = var.resourceGroupRegion
  account_tier             = "Premium"
  static_website {
    index_document = "index.html"
  }
  account_replication_type = "LRS"
  account_kind = "BlockBlobStorage"
  cross_tenant_replication_enabled = "false"
  is_hns_enabled = "false"
  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 7 
    }
    container_delete_retention_policy {
      days = 7 
    }
  }
  tags = {
    project= var.project
    environment = var.env
  }
}