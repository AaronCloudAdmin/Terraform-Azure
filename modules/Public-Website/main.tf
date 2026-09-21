resource "azurerm_virtual_network" "public_website" {
  name                = "vnet-public-website"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.public_website_address_space

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "AppGatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.public_website.name
  address_prefixes     = [var.agw_cidr]
}

resource "azurerm_subnet" "web_subnet" {
  name                 = "WebSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.public_website.name
  address_prefixes     = [var.web_cidr]
}