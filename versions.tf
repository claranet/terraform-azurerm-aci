terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.71"
    }
    azurecaf = {
      source  = "claranet/azurecaf"
      version = "~> 1.2, >= 1.2.22"
    }
  }
}
