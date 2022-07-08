##========================================================================================
##                                                                                      ##
## MAIN                                                                                 ##
##                                                                                      ##
##========================================================================================

##──── Main vars ─────────────────────────────────────────────────────────────────────────
variable "location" {
  type        = string
  default     = "westeurope"
  description = "Location to deploy the resoruce group"
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

variable "standard" {
  type        = string
  description = "Standard PCI or no-PCI"
}

variable "tsi" {
  type        = string
  description = "Tecnical service"
}

variable "environment" {
  type = string
}

variable "prefix" {
  type        = string
  description = "Project prefix on all resources."
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
# variable "vnet_name" {
#   type = string
# }

# ## Subnet name
# variable "subnet_name" {
#   type = string
# }

# ## Private endpoint subnet name
# variable "inboundsubnet_name" {
#   type = string
# }

# variable "private_link_dns_zone" {
#   type = string
# }

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

# variable "vm_nic" {
#   type        = string
#   description = "Virtual machine nic name"
# }

##──── Subnet vars ───────────────────────────────────────────────────────────────────────
#variable "vm_subnet" {
#  type = string
#  description = "Virtual machine subnet name"
#}

##──── Virtual machine vars ──────────────────────────────────────────────────────────────
variable "vmrg" {
  type        = string
  description = "Virtual machine resource group"
}

variable "vm_name" {
  type        = string
  description = "Virtual machine name"
}

variable "vm_count" {
  type        = string
  description = "Virtual machine count"
}

variable "vm_size" {
  type        = list(string)
  description = "Virtual machines list of size, set sequence of all vm."
}

variable "vm_ip" {
  type        = string
  description = "Virtual machine starter ip subnet"
}

variable "ip_shift" {
  type        = number
  description = "Shift ip address creation"
}


##──── Virtual machine data disk ─────────────────────────────────────────────────────────
variable "disk_oracle_data" {
  type        = map(map(string))
  description = "Oracle data disk size and sku."
}

##========================================================================================
##                                                                                      ##
## Encryption Set                                                                       ##
##                                                                                      ##
##========================================================================================

##──── Encryption variables ──────────────────────────────────────────────────────────────
variable "encset_name" {
  type        = string
  description = "Encryption set name."
}
variable "encset_rg" {
  type        = string
  description = "Encryption set resource group."
}

##──── -- ────────────────────────────────────────────────────────────────────────────────
##──── -- ────────────────────────────────────────────────────────────────────────────────
