terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg1" {
  name     = "az104-tf-rg1"
  location = var.location
  tags = {
    environment = var.environment
  }
}

module "hub" {
  source              = "./modules/Hub"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  environment         = var.environment
}
