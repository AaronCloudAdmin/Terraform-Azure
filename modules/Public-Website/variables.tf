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

variable "public_website_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.18.0/24"]
}

variable "agw_cidr" {
  description = "The address prefix for the Application Gateway subnet"
  type        = string
  default     = "10.0.18.0/25"
}

variable "web_cidr" {
  description = "The address prefix for the Web subnet"
  type        = string
  default     = "10.0.18.128/25"
}
