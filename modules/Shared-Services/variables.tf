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

variable "shared-services-address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "identity_cidr" {
  description = "The address prefix for the Identity subnet"
  type        = string
  default     = "10.0.1.0/27"
}

variable "data_cidr" {
  description = "The address prefix for the Data subnet"
  type        = string
  default     = "10.0.1.32/27"
}

variable "mgmt_cidr" {
  description = "The address prefix for the Management subnet"
  type        = string
  default     = "10.0.1.64/27"
}

variable "printer_cidr" {
  description = "The address prefix for the Printer subnet"
  type        = string
  default     = "10.0.1.96/27"
}

variable "apps_cidr" {
  description = "The address prefix for the Apps subnet"
  type        = string
  default     = "10.0.1.128/27"
}

variable "DR_cidr" {
  description = "The address prefix for the Disaster Recovery subnet"
  type        = string
  default     = "10.0.1.160/27"
}

# --- Cross-module references, deferred to hardcoded defaults for now ---

variable "agw_cidr" {
  description = "Application Gateway subnet CIDR (Public-Website module)"
  type        = string
  default     = "10.0.18.0/25"
  # TODO: replace with module.public_website output once wired at root
}

variable "web_cidr" {
  description = "Web subnet CIDR (Public-Website module)"
  type        = string
  default     = "10.0.18.128/25"
  # TODO: replace with module.public_website output once wired at root
}

variable "hq_wired_cidr" {
  description = "HQ's wired-devices subnet CIDR (Admin-Sites module)"
  type        = string
  default     = "10.0.2.0/24"
  # TODO: replace with module.hq.wired_devices_cidr once wired at root
}

variable "annex_wired_cidr" {
  description = "Annex's wired-devices subnet CIDR (Admin-Sites module)"
  type        = string
  default     = "10.0.5.0/24"
  # TODO: replace with module.annex.wired_devices_cidr once wired at root
}

variable "clinic1_wired_cidr" {
  description = "Clinic Region 1's wired-computers subnet CIDR"
  type        = string
  default     = "10.0.8.0/24"
  # TODO: chain from module.clinic1 output once that module exists
}

variable "clinic2_wired_cidr" {
  description = "Clinic Region 2's wired-computers subnet CIDR"
  type        = string
  default     = "10.0.13.0/24"
  # TODO: chain from module.clinic2 output once that module exists
}

variable "bastion_cidr" {
  description = "Hub's AzureBastionSubnet CIDR"
  type        = string
  default     = "10.0.0.128/26"
  # TODO: chain from module.hub output once Hub exposes subnet CIDRs
}
