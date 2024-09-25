variable "fdprofileName" {
  type        = string
  description = "Specifies the name of the Front Door Profile"
}
variable "resourceGroupName" {
  type        = string
  description = "Name for resource group"
}
variable "responseTimeout" {
  type        = number
  description = "Specifies the maximum response timeout in seconds"
  default     = 240
}
variable "fdSkuName" {
  type        = string
  description = "Specifies the SKU for this Front Door Profile"
  default     = "Premium_AzureFrontDoor"
}
variable "appContainerUrl" {
  type        = string
  description = "the address or Domain name of the Origin(Proxy server URL in our case)"
  default = ""
}
variable "project" {
  type        = string
  description = "Project Name"
}
variable "env" {
  type        = string
  description = "Environment name"
}
variable "fdRuleSetName" {
  type        = string
  description = "The name which should be used for this Front Door Rule Set"
  default = "redirectapp"
}
variable "fdRuleName" {
  type        = string
  description = "The name which should be used for this Front Door Rule"
  default = "redirectapp"
}
variable "customDomainName" {
  type        = string
  description = "Custom domain name (seprated with '-') to name the resource in custom domain"
}
variable "domainHostName" {
  type        = string
  description = "Custom domain name"
}
variable "recordName" {
  type        = string
  description = "record name for the subdomain name must be same as subdomain (abc in case of abc.xyz.com)"
}
variable "dnsZoneRG" {
  type        = string
  description = "Resource Group name where the Azure Zone exit"
  default = "xyz-rg"
}
variable "dnsZoneName" {
  type        = string
  description = "Zone name where to add the records"
  default = "xyz.app"
}

