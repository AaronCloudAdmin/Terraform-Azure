# Wired Computers Subnet NSG (VDI thin clients)
resource "azurerm_network_security_group" "wired_computers_nsg" {
  name                = "nsg-wired-computers-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound - VDI protocol (VMware Horizon Blast Extreme) from Bastion/Mgmt only
  security_rule {
    name                       = "allow-blast-extreme-tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22443"
    source_address_prefixes    = [var.bastion_cidr, var.mgmt_cidr]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-blast-extreme-udp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "22443"
    source_address_prefixes    = [var.bastion_cidr, var.mgmt_cidr]
    destination_address_prefix = "*"
  }

  # Outbound - allow to Identity/Data (AD ports)
  security_rule {
    name                         = "allow-identity-data-tcp"
    priority                     = 120
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
    priority                     = 130
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
    priority                     = 140
    direction                    = "Outbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "88"
    source_address_prefix        = "*"
    destination_address_prefixes = [var.identity_cidr, var.data_cidr]
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "wired_computers_nsg_association" {
  subnet_id                 = azurerm_subnet.wired_computers_subnet.id
  network_security_group_id = azurerm_network_security_group.wired_computers_nsg.id
}

#
#
# Wired Printers Subnet NSG
#
#
resource "azurerm_network_security_group" "wired_printers_nsg" {
  name                = "nsg-wired-printers-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-raw-print"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9100"
    source_address_prefixes    = [var.wired_computers_cidr, var.printer_cidr]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-ipp-print"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "631"
    source_address_prefixes    = [var.wired_computers_cidr, var.printer_cidr]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-lpr-lpd-print"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "515"
    source_address_prefixes    = [var.wired_computers_cidr, var.printer_cidr]
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "wired_printers_nsg_association" {
  subnet_id                 = azurerm_subnet.wired_printers_subnet.id
  network_security_group_id = azurerm_network_security_group.wired_printers_nsg.id
}

#
#
# Wired VoIP Subnet NSG
#
#
resource "azurerm_network_security_group" "wired_voip_nsg" {
  name                = "nsg-wired-voip-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # SIP signaling from the apps subnet (VoIP/PBX role)
  security_rule {
    name                       = "allow-sip-tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["5060", "5061"]
    source_address_prefix      = var.apps_cidr
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-sip-udp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "5060"
    source_address_prefix      = var.apps_cidr
    destination_address_prefix = "*"
  }

  # RTP media range - assumption noted; adjust to match actual VoIP vendor spec
  security_rule {
    name                       = "allow-rtp-media-udp"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "16384-32767"
    source_address_prefix      = var.apps_cidr
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "wired_voip_nsg_association" {
  subnet_id                 = azurerm_subnet.wired_voip_subnet.id
  network_security_group_id = azurerm_network_security_group.wired_voip_nsg.id
}

#
#
# Prod WiFi Subnet NSG (same trust level as wired computers)
#
#
resource "azurerm_network_security_group" "prod_wifi_nsg" {
  name                = "nsg-prod-wifi-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

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
# Guest WiFi Subnet NSG (internet-only, isolated from internal ranges)
#
#
resource "azurerm_network_security_group" "guest_wifi_nsg" {
  name                = "nsg-guest-wifi-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

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
