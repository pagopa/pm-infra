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

variable "name" {
  type        = string
  description = "Location of the azure resource group."
}

variable "environment" {
  type        = string
  description = "Name of the deployment environment"
}

variable "location" {
  type        = string
  description = "Location to deploy the resoruce group"
}

variable "plan_sku" {
  type        = string
  description = "The sku of app service plan to create"
}

variable "plan_sku_tier" {
  type        = string
  description = "The sku tier of app service plan to create"
}

variable "plan_kind" {
  type        = string
  description = "The sku kind of app service plan to create. (ES. Linux, Windows)"
}

variable "plan_reserved" {
  type        = string
  description = "(Optional) Is this App Service Plan Reserved. Defaults to false."
  default     = "true"
}


##========================================================================================
##                                                                                      ##
## Application Service                                                                  ##
##                                                                                      ##
##========================================================================================


##──── App service configuration ─────────────────────────────────────────────────────────

## Location of SPRING configuration file
variable "spring_config_location" {
  type        = string
  description = "Spring config location"
}

##──── JAVA OPTS ─────────────────────────────────────────────────────────────────────────

## Java options
variable "java_opts" {
  type        = string
  description = "Set encoding UTF-8"
}

##──── SYSTEM ENCODING ───────────────────────────────────────────────────────────────────

## SET C.UTF-8
variable "system_encoding" {
  type        = string
  description = "Set LANG encoding UTF-8"
  default     = "C.UTF-8"
}

##──── WEBSITE HTTP LOGGING RETENTION DAYS ───────────────────────────────────────────────

variable "http_log_retention_days" {
  type = string
}

##──── APP Service runtime config ────────────────────────────────────────────────────────

## Name
variable "runtime_name" {
  type = string
}
## Version
variable "runtime_version" {
  type = string
}
## App Command Line
variable "app_command_line" {
  type        = string
  default     = ""
  description = "Provide an optional startup command that will be run as part of container startup."
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
variable "endpointsubnet_name" {
  type = string
}

variable "private_link_dns_zone" {
  type = string
}

##========================================================================================
##                                                                                      ##
## Application Gateway                                                                  ##
##                                                                                      ##
##========================================================================================


##──── Application Gateway variables ─────────────────────────────────────────────────────

## APPGTW Resource group
variable "appgw_rg" {
  type        = string
  description = "Application gateway reource group"
}
## APPGTW name
variable "appgw_name" {
  type        = string
  description = "Application gateway name"
}

##  Backend address pool NAME
variable "backend_address_pool_name" {
  type = string
}
## backend HTTP settings host name
variable "backend_http_settings_host_name" {
  type = string
}

## Subnet name
variable "appgw_subnet_name" {
  type = string
}

## Sku size
variable "appgw_sku_size" {
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

variable "vm_size" {
  type = string
  description = "Virtual machine size"
}