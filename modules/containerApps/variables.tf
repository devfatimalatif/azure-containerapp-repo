variable "appEnvironmentId" {
  type        = string
  description = "ID of the Container App Environment within which this Container App should exist"
}
variable "resourceGroupId" {
  type        = string
  description = "Name for resource group"
}
variable "resourceGroupRegion" {
  type        = string
  description = "Name of the region for this infrastructure"
}
variable "containerAppName" {
  type        = string
  description = "Name for this Container App"
}
variable "revisionMode" {
  type        = string
  description = "Revisions operational mode for the Container App"
  default = "Single"
}
variable "project" {
  type        = string
  description = "Project Name"
}
variable "env" {
  type        = string
  description = "Environment name"
}
variable "dockerImage" {
  type        = string
  description = "Image to use to create the container"
  default = ""
}
variable "containerCpuValue" {
  type        = number
  description = "Amount of vCPU to allocate to the container"
  default = 0.25
}
variable "containerMemoryValue" {
  type        = string
  description = "Amount of memory to allocate to the container"
  default = "0.5Gi"
}
variable "dockerUserName" {
  type        = string
  description = "Username to use for this Container Registry"
  default = "ahassan-lc"
}
variable "dockerUserPassword" {
  type        = string
  description = "Password to use for this Container Registry"
  default = "dockerpassword"
}
variable "keyVaultName" {
  type        = string
  description = "Name of key vault to store secrets"
  default = "testAPisVault"
}
variable "keyVaultRG" {
  type        = string
  description = "Resource group where key vault exits"
  default = "xyz-RG"
}
variable "secrets" {
  type = list(string)
  description = "List of secrets variables name fetched from the vault"
  default = []
}
variable "envVariables" {
  type = map(string)
  description = "Mapping of secrets to the environment variable"
  default = {}
}
variable "maxReplicas" {
  type        = number
  description = "Maximum number of container app replicas"
  default = 2
}
variable "minReplicas" {
  type        = number
  description = "Minimum number of container app replicas"
  default = 1
}


