terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.52.0"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
}
provider "azurerm" {
  alias = "production"
  features {}
  subscription_id = "0000-0000-0000-0000"
}