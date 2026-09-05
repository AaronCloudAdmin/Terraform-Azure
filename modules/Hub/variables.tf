variable "location" {
  description = "The location for the resources"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg1"
}

variable "environment" {
  description = "The environment for the deployment"
  type        = string
  default     = "dev"
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "firewall_subnet_prefix" {
  description = "The address prefix for the Azure Firewall subnet"
  type        = string
  default     = "10.0.0.0/26"
}

variable "gateway_subnet_prefix" {
  description = "The address prefix for the Gateway subnet"
  type        = string
  default     = "10.0.0.64/27"
}
variable "private_dns_subnet_prefix" {
  description = "The address prefix for the Private DNS subnet"
  type        = string
  default     = "10.0.0.96/28"
}

variable "bastion_subnet_prefix" {
  description = "The address prefix for the Azure Bastion subnet"
  type        = string
  default     = "10.0.0.128/26"
}
