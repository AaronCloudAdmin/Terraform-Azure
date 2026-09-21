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

variable "address_space" {
  description = "The address space for this clinic's virtual network"
  type        = list(string)
}

variable "wired_computers_cidr" {
  description = "The address prefix for the Wired Computers subnet"
  type        = string
}

variable "wired_printers_cidr" {
  description = "The address prefix for the Wired Printers subnet"
  type        = string
}

variable "wired_voip_cidr" {
  description = "The address prefix for the Wired VoIP subnet"
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

# --- Cross-module references ---

variable "identity_cidr" {
  description = "Shared-Services Identity subnet CIDR"
  type        = string
}

variable "data_cidr" {
  description = "Shared-Services Data subnet CIDR"
  type        = string
}

variable "mgmt_cidr" {
  description = "Shared-Services Mgmt subnet CIDR"
  type        = string
}

variable "apps_cidr" {
  description = "Shared-Services Apps subnet CIDR (VoIP/PBX role assumed to live here)"
  type        = string
}

variable "printer_cidr" {
  description = "Shared-Services Printer subnet CIDR"
  type        = string
}

variable "bastion_cidr" {
  description = "Hub AzureBastionSubnet CIDR"
  type        = string
  default     = "10.0.0.128/26"
  # TODO: chain from module.hub output once Hub exposes subnet CIDRs
}
