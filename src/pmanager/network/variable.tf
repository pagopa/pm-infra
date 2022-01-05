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