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
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "firewall_cidr" {
  description = "The address prefix for the Azure Firewall subnet"
  type        = string
  default     = "10.0.0.0/26"
}

variable "gateway_cidr" {
  description = "The address prefix for the Gateway subnet"
  type        = string
  default     = "10.0.0.64/27"
}
variable "private_dns_cidr" {
  description = "The address prefix for the Private DNS subnet"
  type        = string
  default     = "10.0.0.96/28"
}

variable "bastion_cidr" {
  description = "The address prefix for the Azure Bastion subnet"
  type        = string
  default     = "10.0.0.128/26"
}
