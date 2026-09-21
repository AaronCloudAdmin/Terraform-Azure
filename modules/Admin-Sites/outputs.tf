output "admin_site_vnet_id" {
  value = azurerm_virtual_network.admin_site.id
}

output "vnet_name" {
  value = azurerm_virtual_network.admin_site.name
}

output "subnet_ids" {
  description = "Map of Admin-Site subnet names to their resource IDs"
  value = {
    wired_devices = azurerm_subnet.wired_devices_subnet.id
    prod_wifi     = azurerm_subnet.prod_wifi_subnet.id
    guest_wifi    = azurerm_subnet.guest_wifi_subnet.id
  }
}

output "wired_devices_cidr" {
  value = var.wired_devices_cidr
}