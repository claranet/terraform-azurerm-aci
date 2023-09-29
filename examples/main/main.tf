terraform {
  required_version = ">= 1.3, < 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.71"
    }
  }
}

provider "azurerm" {
  features {}
}
