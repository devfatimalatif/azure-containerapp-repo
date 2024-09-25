variable "appEnvironmentName" {
  type        = string
  description = "Name of the Container Apps Managed Environment"
}
variable "resourceGroupName" {
  type        = string
  description = "Name for resource group"
}
variable "resourceGroupRegion" {
  type        = string
  description = "Name of the region for this infrastructure"
}
variable "logWorkSpaceId" {
  type        = string
  description = "Name of the Log analytics workspace"
}
variable "isZoneRedundant" {
  type        = bool
  description = "Should the App Environment be created with Zone Redundancy enabled"
  default = false
}
variable "project" {
  type        = string
  description = "Project Name"
}
variable "env" {
  type        = string
  description = "Environment name"
}