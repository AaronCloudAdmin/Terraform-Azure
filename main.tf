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

module "shared_services" {
  source              = "./modules/Shared-Services"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  environment         = var.environment
}

module "public_website" {
  source              = "./modules/Public-Website"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  environment         = var.environment
}

module "hq" {
  source                   = "./modules/Admin-Sites"
  location                 = azurerm_resource_group.rg1.location
  resource_group_name      = azurerm_resource_group.rg1.name
  environment              = var.environment
  admin_site_address_space = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  wired_devices_cidr       = "10.0.2.0/24"
  prod_wifi_cidr           = "10.0.3.0/24"
  guest_wifi_cidr          = "10.0.4.0/24"
  identity_cidr            = module.shared_services.identity_cidr
  data_cidr                = module.shared_services.data_cidr
}

module "annex" {
  source                   = "./modules/Admin-Sites"
  location                 = azurerm_resource_group.rg1.location
  resource_group_name      = azurerm_resource_group.rg1.name
  environment              = var.environment
  admin_site_address_space = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
  wired_devices_cidr       = "10.0.5.0/24"
  prod_wifi_cidr           = "10.0.6.0/24"
  guest_wifi_cidr          = "10.0.7.0/24"
  identity_cidr            = module.shared_services.identity_cidr
  data_cidr                = module.shared_services.data_cidr
}

module "clinic1" {
  source               = "./modules/Clinic-Sites"
  location             = azurerm_resource_group.rg1.location
  resource_group_name  = azurerm_resource_group.rg1.name
  environment          = var.environment
  address_space        = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  wired_computers_cidr = "10.0.8.0/24"
  wired_printers_cidr  = "10.0.9.0/24"
  wired_voip_cidr      = "10.0.10.0/24"
  prod_wifi_cidr       = "10.0.11.0/24"
  guest_wifi_cidr      = "10.0.12.0/24"
  identity_cidr        = module.shared_services.identity_cidr
  data_cidr            = module.shared_services.data_cidr
  mgmt_cidr            = module.shared_services.mgmt_cidr
  apps_cidr            = module.shared_services.apps_cidr
  printer_cidr         = module.shared_services.printer_cidr
}

module "clinic2" {
  source               = "./modules/Clinic-Sites"
  location             = azurerm_resource_group.rg1.location
  resource_group_name  = azurerm_resource_group.rg1.name
  environment          = var.environment
  address_space        = ["10.0.13.0/24", "10.0.14.0/24", "10.0.15.0/24", "10.0.16.0/24", "10.0.17.0/24"]
  wired_computers_cidr = "10.0.13.0/24"
  wired_printers_cidr  = "10.0.14.0/24"
  wired_voip_cidr      = "10.0.15.0/24"
  prod_wifi_cidr       = "10.0.16.0/24"
  guest_wifi_cidr      = "10.0.17.0/24"
  identity_cidr        = module.shared_services.identity_cidr
  data_cidr            = module.shared_services.data_cidr
  mgmt_cidr            = module.shared_services.mgmt_cidr
  apps_cidr            = module.shared_services.apps_cidr
  printer_cidr         = module.shared_services.printer_cidr
}
