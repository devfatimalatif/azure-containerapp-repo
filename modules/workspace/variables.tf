variable "resourceGroupName" {
  type        = string
  description = "Name for resource group"
}
variable "resourceGroupRegion" {
  type        = string
  description = "Name of the region for this infrastructure"
}
variable "logAnalyticsWorkspaceName" {
  type        = string
  description = "Name of the Log analytics workspace"
}
variable "project" {
  type        = string
  description = "Project Name"
}
variable "env" {
  type        = string
  description = "Environment name"
}
variable "logRetentionPeriod" {
  type        = number
  description = "Workspace data retention in days"
}
