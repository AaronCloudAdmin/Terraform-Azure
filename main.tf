terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "az104-tf-rg1" {
  name     = "az104-tf-rg1"
  location = "East US"
  tags = {
    environment = "dev"
  }
}
    