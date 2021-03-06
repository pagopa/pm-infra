#variable "rg" {
#  type        = string
#  description = "Resource group variable."
#}

variable "environment" {
  type        = string
  description = "Name of the deployment environment"
}

variable "location" {
  type        = string
  description = "Location to deploy the resoruce group"
}

variable "standard" {
  type        = string
  description = "Standard pci/no-pci tags"
}

variable "tsi" {
  type        = string
  description = "Tecnical service."
  default     = ""
}

## Network configuration variables
#########################################################
# Network resource
variable "network_resource" {
  type = string
}

## VNET name
variable "vnet_outgoing_name" {
  type = string
}

variable "vnet_inbound_name" {
  type = string
}

variable "vnet_database_name" {
  type = string
}

variable "vnet_subnet1" {
  type = string
}

variable "vnet_subnet1_address" {
  type = string
}

variable "vnet_subnet2" {
  type = string
}

variable "vnet_subnet2_address" {
  type = string
}

## Address space
#variable "address_space" {
#    type = list(string)
#}

#variable "subnet_address_space" {
#    type = list(string)
#}
## Subnet name
#variable "subnet_name" {
#    type = string
#}

##──── Key Vault ─────────────────────────────────────────────────────────────────────────

variable "key_vault" {
  type        = string
  description = "Key Vault name"
}

variable "key_vault_rg" {
  type        = string
  description = "Key Vault resource group"
}