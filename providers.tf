terraform {
  required_version = ">=0.12"
  required_providers {
    azapi = {
      source  = "registry.terraform.io/azure/azapi"
      version = "1.12.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.52.0"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}
provider "azurerm" {
  features {}
}
provider "azapi" {
}

