resource "azurerm_virtual_network" "shared_services" {
  name                = "vnet-shared-services-network"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "identity_subnet" {
  name                 = "IdentitySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.shared_services.name
  address_prefixes     = [var.identity_subnet_prefix]
}

resource "azurerm_subnet" "data_subnet" {
  name                 = "DataSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.shared_services.name
  address_prefixes     = [var.data_subnet_prefix]
}

resource "azurerm_subnet" "mgmt_subnet" {
  name                 = "MgmtSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.shared_services.name
  address_prefixes     = [var.mgmt_subnet_prefix]
}

resource "azurerm_subnet" "printer_subnet" {
  name                 = "PrinterSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.shared_services.name
  address_prefixes     = [var.printer_subnet_prefix]
}

resource "azurerm_subnet" "apps_subnet" {
  name                 = "AppsSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.shared_services.name
  address_prefixes     = [var.apps_subnet_prefix]
}

resource "azurerm_subnet" "disaster_recovery_subnet" {
  name                 = "DisasterRecoverySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.shared_services.name
  address_prefixes     = [var.DR_subnet_prefix]
}