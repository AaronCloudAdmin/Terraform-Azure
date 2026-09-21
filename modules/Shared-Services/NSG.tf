# Identity Subnet NSG
resource "azurerm_network_security_group" "Identity_Subnet_NSG" {
  name                = "nsg-identity-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound Rules for Identity Subnet
  security_rule {
    name                       = "allow-kerberos-tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "88"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-kerberos-udp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "88"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-ldap-udp"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "389"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-ldap-tcp"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "389"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-smb-tcp"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "445"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-kerberos-pw-change-tcp"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "464"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-kerberos-pw-change-udp"
    priority                   = 160
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "464"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-ldaps-tcp"
    priority                   = 170
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "636"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-global-catalog-tcp"
    priority                   = 180
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3268-3269"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-internet"
    priority                   = 190
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }


  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "Identity_Subnet_NSG_Association" {
  subnet_id                 = azurerm_subnet.identity_subnet.id
  network_security_group_id = azurerm_network_security_group.Identity_Subnet_NSG.id
}

#
#
# Data Subnet NSG
#
#
resource "azurerm_network_security_group" "Data_Subnet_NSG" {
  name                = "nsg-data-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound Rules for Data Subnet
  security_rule {
    name                       = "allow-sql-server-tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefixes    = [var.mgmt_cidr, var.apps_cidr, var.agw_cidr, var.web_cidr]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-smb-tcp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "445"
    source_address_prefixes    = [var.hq_wired_cidr, var.annex_wired_cidr, var.clinic1_wired_cidr, var.clinic2_wired_cidr]
    destination_address_prefix = "*"
  }

  # Explicit Deny All Other Inbound Rule
  security_rule {
    name                       = "deny-all-inbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "data_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.data_subnet.id
  network_security_group_id = azurerm_network_security_group.Data_Subnet_NSG.id
}

#
#
# Mgmt Subnet NSG
#
#
resource "azurerm_network_security_group" "Mgmt_Subnet_NSG" {
  name                = "nsg-mgmt-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound Rules for Mgmt Subnet
  security_rule {
    name                       = "allow-rdp-tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.bastion_cidr
    destination_address_prefix = "*"
  }

  # Explicit Deny All Other Inbound Rule
  security_rule {
    name                       = "deny-all-inbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "mgmt_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.mgmt_subnet.id
  network_security_group_id = azurerm_network_security_group.Mgmt_Subnet_NSG.id
}

#
#
# Printer Subnet NSG
#
#
resource "azurerm_network_security_group" "Printer_Subnet_NSG" {
  name                = "nsg-printer-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound Rules for Printer Subnet
  security_rule {
    name                       = "allow-raw-print"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9100"
    source_address_prefixes    = [var.hq_wired_cidr, var.annex_wired_cidr, var.clinic1_wired_cidr, var.clinic2_wired_cidr]
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
    source_address_prefixes    = [var.hq_wired_cidr, var.annex_wired_cidr, var.clinic1_wired_cidr, var.clinic2_wired_cidr]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-lrp-lrd-print"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "515"
    source_address_prefixes    = [var.hq_wired_cidr, var.annex_wired_cidr, var.clinic1_wired_cidr, var.clinic2_wired_cidr]
    destination_address_prefix = "*"
  }

  # Explicit Deny All Other Inbound Rule
  security_rule {
    name                       = "deny-all-inbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "printer_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.printer_subnet.id
  network_security_group_id = azurerm_network_security_group.Printer_Subnet_NSG.id
}

#
#
# Apps Subnet NSG
#
#
resource "azurerm_network_security_group" "Apps_Subnet_NSG" {
  name                = "nsg-apps-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound Rules for Apps Subnet
  security_rule {
    name                       = "allow-agw-web-https"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefixes    = [var.agw_cidr, var.web_cidr]
    destination_address_prefix = "*"
  }

  # Outbound Rules for Apps Subnet
  security_rule {
    name                       = "allow-outbound-m365-graph-https"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureActiveDirectory"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "apps_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.apps_subnet.id
  network_security_group_id = azurerm_network_security_group.Apps_Subnet_NSG.id
}

#
#
# Disaster Recovery Subnet NSG
#
#
resource "azurerm_network_security_group" "Disaster_Recovery_Subnet_NSG" {
  name                = "nsg-disaster-recovery-subnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound Rules for Disaster Recovery Subnet
  security_rule {
    name                       = "allow"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "disaster_recovery_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.disaster_recovery_subnet.id
  network_security_group_id = azurerm_network_security_group.Disaster_Recovery_Subnet_NSG.id
}
