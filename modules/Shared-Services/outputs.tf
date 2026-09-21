output "vnet_id" {
  value = azurerm_virtual_network.shared_services.id
}

output "vnet_name" {
  value = azurerm_virtual_network.shared_services.name
}

output "subnet_ids" {
  description = "Map of Shared-Services subnet names to their resource IDs"
  value = {
    identity          = azurerm_subnet.identity_subnet.id
    data              = azurerm_subnet.data_subnet.id
    mgmt              = azurerm_subnet.mgmt_subnet.id
    printer           = azurerm_subnet.printer_subnet.id
    apps              = azurerm_subnet.apps_subnet.id
    disaster_recovery = azurerm_subnet.disaster_recovery_subnet.id
  }
}

output "data_cidr" {
  value = var.data_cidr
}

output "identity_cidr" {
  value = var.identity_cidr
}

output "mgmt_cidr" {
  value = var.mgmt_cidr
}

output "apps_cidr" {
  value = var.apps_cidr
}

output "printer_cidr" {
  value = var.printer_cidr
}
