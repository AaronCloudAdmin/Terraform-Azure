variable "location" {
  description = "The location for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment"
  type        = string
}

variable "admin_site_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "wired_devices_cidr" {
  description = "The address prefix for the Wired Devices subnet"
  type        = string
}

variable "prod_wifi_cidr" {
  description = "The address prefix for the Prod WiFi subnet"
  type        = string
}

variable "guest_wifi_cidr" {
  description = "The address prefix for the Guest WiFi subnet"
  type        = string
}

variable "identity_cidr" {
  description = "The address prefix for the Identity subnet"
  type        = string
}

variable "data_cidr" {
  description = "The address prefix for the Data subnet"
  type        = string
}

