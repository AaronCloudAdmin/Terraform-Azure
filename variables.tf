variable "location" {
  description = "The Azure region for all resources"
  type        = string
}

variable "environment" {
  description = "The environment name (dev, staging, prod, etc.)"
  type        = string
}