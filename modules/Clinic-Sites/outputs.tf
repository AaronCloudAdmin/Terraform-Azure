output "vnet_id" {
  value = azurerm_virtual_network.clinic.id
}

output "vnet_name" {
  value = azurerm_virtual_network.clinic.name
}

output "subnet_ids" {
  description = "Map of Clinic-Spoke subnet names to their resource IDs"
  value = {
    wired_computers = azurerm_subnet.wired_computers_subnet.id
    wired_printers  = azurerm_subnet.wired_printers_subnet.id
    wired_voip      = azurerm_subnet.wired_voip_subnet.id
    prod_wifi       = azurerm_subnet.prod_wifi_subnet.id
    guest_wifi      = azurerm_subnet.guest_wifi_subnet.id
  }
}

output "wired_computers_cidr" {
  value = var.wired_computers_cidr
}
