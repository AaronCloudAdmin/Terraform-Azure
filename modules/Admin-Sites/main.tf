resource "azurerm_virtual_network" "admin_site" {
  name                = "vnet-admin-site-network"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.admin_site_address_space

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "wired_devices_subnet" {
  name                 = "WiredDevicesSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.admin_site.name
  address_prefixes     = [var.wired_devices_cidr]
}

resource "azurerm_subnet" "prod_wifi_subnet" {
  name                 = "ProdWiFiSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.admin_site.name
  address_prefixes     = [var.prod_wifi_cidr]
}

resource "azurerm_subnet" "guest_wifi_subnet" {
  name                 = "GuestWiFiSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.admin_site.name
  address_prefixes     = [var.guest_wifi_cidr]
}