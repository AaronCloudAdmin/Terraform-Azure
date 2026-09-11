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
  default     = ["10.0.1.0/24"]
}

variable "identity_subnet_prefix" {
  description = "The address prefix for the Identity subnet"
  type        = string
  default     = "10.0.1.0/27"
}

variable "data_subnet_prefix" {
  description = "The address prefix for the Data subnet"
  type        = string
  default     = "10.0.1.32/27"
}
variable "mgmt_subnet_prefix" {
  description = "The address prefix for the Management subnet"
  type        = string
  default     = "10.0.1.64/27"
}

variable "printer_subnet_prefix" {
  description = "The address prefix for the Printer subnet"
  type        = string
  default     = "10.0.1.96/27"
}

variable "apps_subnet_prefix" {
  description = "The address prefix for the Apps subnet"
  type        = string
  default     = "10.0.1.128/27"
}

variable "DR_subnet_prefix" {
  description = "The address prefix for the Disaster Recovery subnet"
  type        = string
  default     = "10.0.1.160/27"
}