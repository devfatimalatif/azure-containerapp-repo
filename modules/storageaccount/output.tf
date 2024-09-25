output "primaryWebEndpoint" {
    description = "The endpoint URL for web storage in the primary location"
    value = azurerm_storage_account.storageaccount.primary_web_endpoint
}