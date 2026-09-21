output "vnet_id" {
  value = azurerm_virtual_network.public_website.id
}

output "vnet_name" {
  value = azurerm_virtual_network.public_website.name
}

output "subnet_ids" {
  description = "Map of Public-Website subnet names to their resource IDs"
  value = {
    AppGateway = azurerm_subnet.app_gateway_subnet.id
    PublicWeb  = azurerm_subnet.web_subnet.id
  }
}