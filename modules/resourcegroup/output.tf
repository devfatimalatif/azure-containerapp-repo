output "resourceGroupName" {
  description = "Name of the resourceGroup"
  value       = azurerm_resource_group.azureRG.name
}
output "resourceGroupId" {
  description = "Id of the resourceGroup"
  value       = azurerm_resource_group.azureRG.id
}
output "resourceGroupRegion" {
  description = "Region of the resourceGroup"
  value       = azurerm_resource_group.azureRG.location
}