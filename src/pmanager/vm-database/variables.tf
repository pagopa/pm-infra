##========================================================================================
##                                                                                      ##
## MAIN                                                                                 ##
##                                                                                      ##
##========================================================================================

##──── Main vars ─────────────────────────────────────────────────────────────────────────

variable "rg" {
  type        = string
  description = "Resource group variable."
}

variable "environment" {
  type        = string
  description = "Name of the deployment environment"
}

variable "location" {
  type        = string
  description = "Location to deploy the resoruce group"
}

##========================================================================================
##                                                                                      ##
## Main network vars                                                                    ##
##                                                                                      ##
##========================================================================================

##──── Network configuration variables ───────────────────────────────────────────────────

## Network resource
variable "network_resource" {
  type = string
}

## VNET name
variable "vnet_name" {
  type = string
}

## Subnet name
variable "subnet_name" {
  type = string
}

## Private endpoint subnet name
variable "inboundsubnet_name" {
  type = string
}

variable "private_link_dns_zone" {
  type = string
}

##──── Key Vault ─────────────────────────────────────────────────────────────────────────

variable "key_vault" {
  type        = string
  description = "Key Vault name"
}

variable "key_vault_rg" {
  type        = string
  description = "Key Vault resource group"
}

##========================================================================================
##                                                                                      ##
## Virual machine config vars                                                           ##
##                                                                                      ##
##========================================================================================

##──── Virtual network vars ──────────────────────────────────────────────────────────────
variable "vm_network_name" {
  type        = string
  description = "Virtual machine network name"
}

#variable "vm_network_addess_space" {
#  type        = string
#  description = "Virtual network address space"
#}

variable "vm_nic" {
  type = string
  description = "Virtual machine nic name"
}

##──── Subnet vars ───────────────────────────────────────────────────────────────────────
#variable "vm_subnet" {
#  type = string 
#  description = "Virtual machine subnet name"
#}

##──── Virtual machine vars ──────────────────────────────────────────────────────────────
variable "vmrg" {
  type = string
  description = "Virtual machine resource group"
}

variable "vm_name" {
  type = string
  description = "Virtual machine name"
}

variable "vm_count" {
  type        = string
  description = "Virtual machine count"
}

variable "vm_size" {
  type = string
  description = "Virtual machine size"
}

##──── Virtual machine data disk ─────────────────────────────────────────────────────────
variable "disk_oracle_vgdb_size" {
  type = string
  description = "Oracle vgdb disk size"
}

variable "disk_oracle_data_size" {
  type = string
  description = "Oracle data disk size"
}

variable "disk_oracle_reco_size" {
  type = string
  description = "Oracle reco disk size"
}

variable "disk_oracle_has_size" {
  type = string
  description = "Oracle has disk size"
}
