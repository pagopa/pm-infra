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

## Sku capacity
variable "appgw_sku_capacity" {
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