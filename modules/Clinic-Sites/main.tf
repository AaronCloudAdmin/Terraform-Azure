resource "azurerm_virtual_network" "clinic" {
  name                = "vnet-clinic-network"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "wired_computers_subnet" {
  name                 = "WiredComputersSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.clinic.name
  address_prefixes     = [var.wired_computers_cidr]
}

resource "azurerm_subnet" "wired_printers_subnet" {
  name                 = "WiredPrintersSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.clinic.name
  address_prefixes     = [var.wired_printers_cidr]
}

resource "azurerm_subnet" "wired_voip_subnet" {
  name                 = "WiredVoipSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.clinic.name
  address_prefixes     = [var.wired_voip_cidr]
}

resource "azurerm_subnet" "prod_wifi_subnet" {
  name                 = "ProdWiFiSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.clinic.name
  address_prefixes     = [var.prod_wifi_cidr]
}

resource "azurerm_subnet" "guest_wifi_subnet" {
  name                 = "GuestWiFiSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.clinic.name
  address_prefixes     = [var.guest_wifi_cidr]
}
