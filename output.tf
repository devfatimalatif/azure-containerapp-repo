output "envId" {
  description = "environment Id"
  value       = module.appEnvironment.appEnvironmentId
}
# output "azregion" {
#   description = "environment Id"
#   value       = module.resourceGroup.resourceGroupRegion
# }
output "logWorkSpaceId" {
  description = "logWorkSpaceId"
  value       = module.logWorkspace.logWorkSpaceId
}
output "apis_container_app_urls" {
  value = module.apiscontainerapp["apis"].containerAppUrl
}

# output "mailgun_container_app_urls" {
#   value = module.mailguncontainerapp[mailgun].containerAppUrl
# }

# output "workflow_container_app_urls" {
#   value = module.workflowcontainerapp[workflow].containerAppUrl
# }

# output "mutualizer_container_app_urls" {
#   value = module.mutualizercontainerapp[mutualizer].containerAppUrl
# }

# output "lawvu_container_app_urls" {
#   value = module.lawvucontainerapp[lawvu].containerAppUrl
# }

# output "olang_container_app_urls" {
#   value = module.olangcontainerapp["olang"].containerAppUrl
# }

# output "proxy_container_app_urls" {
#   value = module.proxycontainerapp[proxy].containerAppUrl
# }

# output "primaryWebEndpoint" {
#   description = "The endpoint URL for web storage in the primary location"
#   value       = module.storageaccount.primaryWebEndpoint
# }


