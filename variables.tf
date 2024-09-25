variable "project" {
  type        = string
  description = "Project Name"
}
variable "env" {
  type        = string
  description = "Environment name"
}
# variable "rgName" {
#   type        = string
#   description = "Name for resource group"
# }
# variable "azRegion" {
#   type        = string
#   description = "Name of the region for this infrastructure"
# }
variable "appEnvironmentName" {
  type        = string
  description = "Name of the Container Apps Managed Environment"
}
variable "logAnalyticsWorkspaceName" {
  type        = string
  description = "Name of the Log analytics workspace"
}
# variable "storageAccountNames" {
#   type    = list(string)
#   default = [] # Add more storage account names as needed
# }
# variable "fdprofileName" {
#   type        = string
#   description = "Specifies the name of the Front Door Profile"
#   default     = "abcfrontdoor"
# }
# variable "customDomainName" {
#   type        = string
#   description = "Custom domain name (seprated with '-') to name the resource in custom domain"
#   default     = "abc-xyz-app"
# }
# variable "domainHostName" {
#   type        = string
#   description = "Custom domain name"
#   default     = "abc.xyz.app"
# }
# variable "recordName" {
#   type        = string
#   description = "record name for the subdomain name"
#   default     = "abc"
# }
# variable "dnsZoneRG" {
#   type        = string
#   description = "Resource Group name where the Azure Zone exit"
#   default     = "xyz-rg"
# }
# variable "dnsZoneName" {
#   type        = string
#   description = "Zone name where to add the records"
#   default     = "xyz.app"
# }
variable "dockerUserPassword" {
  type        = string
  description = "Password to use for this Container Registry (This secrets must be exit in all azure key vaults to acces the ghcr)"
  default     = "dockerpassword"
}
variable "apiscontainerapps" {
  type = map(object({
    containerAppName = string
    min_replicas     = number
    keyVaultName     = string
    max_replicas     = number
    docker_image     = string
    secrets          = list(string)
    env_variables    = map(string)
  }))
}
variable "mutualizercontainerapps" {
  type = map(object({
    containerAppName = string
    min_replicas     = number
    keyVaultName     = string
    max_replicas     = number
    docker_image     = string
    secrets          = list(string)
    env_variables    = map(string)
  }))
}

# variable "mailguncontainerapps" {
#   type = map(object({
#     containerAppName = string
#     min_replicas     = number
#     keyVaultName     = string
#     max_replicas     = number
#     docker_image     = string
#     secrets          = list(string)
#     env_variables    = map(string)
#   }))
# }

# variable "workflowcontainerapps" {
#   type = map(object({
#     containerAppName = string
#     min_replicas     = number
#     keyVaultName     = string
#     max_replicas     = number
#     docker_image     = string
#     secrets          = list(string)
#     env_variables    = map(string)
#   }))
# }

# variable "lawvucontainerapps" {
#   type = map(object({
#     containerAppName = string
#     min_replicas     = number
#     keyVaultName     = string
#     max_replicas     = number
#     docker_image     = string
#     secrets          = list(string)
#     env_variables    = map(string)
#   }))
# }

# variable "olangcontainerapps" {
#   type = map(object({
#     containerAppName = string
#     min_replicas     = number
#     keyVaultName     = string
#     max_replicas     = number
#     docker_image     = string
#     secrets          = list(string)
#     env_variables    = map(string)
#   }))
# }

# variable "proxycontainerapps" {
#   type = map(object({
#     containerAppName = string
#     min_replicas     = number
#     keyVaultName     = string
#     max_replicas     = number
#     docker_image     = string
#   }))
# }