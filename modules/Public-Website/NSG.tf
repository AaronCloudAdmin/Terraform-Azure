# Application Gateway Subnet NSG
resource "azurerm_network_security_group" "app_gateway_subnet_nsg" {
  name                = "nsg-appgateway-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound Rules for App Gateway Subnet
  security_rule {
    name                       = "allow-https-tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http-tcp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-gatewaymanager-tcp"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "app_gateway_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.app_gateway_subnet.id
  network_security_group_id = azurerm_network_security_group.app_gateway_subnet_nsg.id
}

#
#
# Public Website Subnet NSG
#
#

resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "nsg-web-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound Rules for Web Subnet
  security_rule {
    name                       = "allow-https-tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.agw_cidr
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http-tcp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = var.agw_cidr
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}
