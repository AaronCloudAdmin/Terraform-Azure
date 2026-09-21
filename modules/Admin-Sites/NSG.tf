# NSG for Wired Devices Subnet
resource "azurerm_network_security_group" "wired_devices_nsg" {
  name                = "nsg-wired-devices-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Outbound Rules for Wired Devices Subnet
  security_rule {
    name                         = "allow-identity-data-tcp"
    priority                     = 100
    direction                    = "Outbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_ranges      = ["389", "445", "464", "636", "3268-3269"]
    source_address_prefix        = "*"
    destination_address_prefixes = [var.identity_cidr, var.data_cidr]
  }

  security_rule {
    name                         = "allow-identity-data-udp"
    priority                     = 110
    direction                    = "Outbound"
    access                       = "Allow"
    protocol                     = "Udp"
    source_port_range            = "*"
    destination_port_ranges      = ["88", "389", "464"]
    source_address_prefix        = "*"
    destination_address_prefixes = [var.identity_cidr, var.data_cidr]
  }

  security_rule {
    name                         = "allow-identity-data-kerberos-tcp"
    priority                     = 120
    direction                    = "Outbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "88"
    source_address_prefix        = "*"
    destination_address_prefixes = [var.identity_cidr, var.data_cidr]
  }

  security_rule {
    name                       = "deny-direct-internet"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "wired_devices_nsg_association" {
  subnet_id                 = azurerm_subnet.wired_devices_subnet.id
  network_security_group_id = azurerm_network_security_group.wired_devices_nsg.id
}

#
#
# NSG for Prod WiFi Subnet (same trust level as wired devices)
#
#
resource "azurerm_network_security_group" "prod_wifi_nsg" {
  name                = "nsg-prod-wifi-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Outbound Rules for Prod WiFi Subnet
  security_rule {
    name                         = "allow-identity-data-tcp"
    priority                     = 100
    direction                    = "Outbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_ranges      = ["389", "445", "464", "636", "3268-3269"]
    source_address_prefix        = "*"
    destination_address_prefixes = [var.identity_cidr, var.data_cidr]
  }

  security_rule {
    name                         = "allow-identity-data-udp"
    priority                     = 110
    direction                    = "Outbound"
    access                       = "Allow"
    protocol                     = "Udp"
    source_port_range            = "*"
    destination_port_ranges      = ["88", "389", "464"]
    source_address_prefix        = "*"
    destination_address_prefixes = [var.identity_cidr, var.data_cidr]
  }

  security_rule {
    name                         = "allow-identity-data-kerberos-tcp"
    priority                     = 120
    direction                    = "Outbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "88"
    source_address_prefix        = "*"
    destination_address_prefixes = [var.identity_cidr, var.data_cidr]
  }

  security_rule {
    name                       = "deny-direct-internet"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "prod_wifi_nsg_association" {
  subnet_id                 = azurerm_subnet.prod_wifi_subnet.id
  network_security_group_id = azurerm_network_security_group.prod_wifi_nsg.id
}

#
#
# NSG for Guest WiFi Subnet (internet-only, isolated from internal ranges)
#
#
resource "azurerm_network_security_group" "guest_wifi_nsg" {
  name                = "nsg-guest-wifi-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Outbound Rules for Guest WiFi Subnet
  security_rule {
    name                       = "allow-internet-http-https"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  security_rule {
    name                       = "deny-internal-ranges"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.0.0/8"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "guest_wifi_nsg_association" {
  subnet_id                 = azurerm_subnet.guest_wifi_subnet.id
  network_security_group_id = azurerm_network_security_group.guest_wifi_nsg.id
}
