variable "resourceGroupName" {
  type        = string
  description = "Name for resource group"
}
variable "resourceGroupRegion" {
  type        = string
  description = "Name of the region for this infrastructure"
}
variable "storageAccountName" {
  type        = string
  description = "Name of the storage account(valid name must be added)"
}
variable "project" {
  type        = string
  description = "Project Name"
}
variable "env" {
  type        = string
  description = "Environment name"
}