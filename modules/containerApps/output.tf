output "containerAppId" {
  description = "Id the of the Container App"
  value = azapi_resource.containerapp.id
}
output "containerAppUrl" {
  description = "Url the of the Container App"
  value = "https://${jsondecode(azapi_resource.containerapp.output).properties.configuration.ingress.fqdn}"
}
output "fetchedvalues" {
  value = { for s in var.secrets : s => lookup(data.azurerm_key_vault_secret.fetched_secrets[s], "value", null) }
  description = "The fetched secret values from Azure Key Vault."
  sensitive = true
}
