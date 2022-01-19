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

variable "standard" {
  type = string
  description = "Standard pci/no-pci tags"
}  

variable "location" {
  type        = string
  description = "Location to deploy the resoruce group"
}

variable "plan_id" {
  type        = string
  description = "(Optional) Specifies the external app service plan id."
  default     = null
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

##──── App Service Plan ──────────────────────────────────────────────────────────────────

variable "admin_panel_plan" {
  type = string
  description = "Admin Panel app service plan"
}

variable "batch_plan" {
  type = string
  description = "Batch app service plan"
}

variable "logging_plan" {
  type = string
  description = "Logging app service plan"
}

variable "restapi_io_plan" {
  type = string
  description = "Admin Panel app service plan"
}

variable "restapi_plan" {
  type = string
  description = "Admin Panel app service plan"
}

variable "rtd_plan" {
  type = string
  description = "Rtd app service plan"
}

variable "wisp_plan" {
  type = string
  description = "wisp app service plan"
}

##──── App service configuration ─────────────────────────────────────────────────────────

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
variable "vnet_outgoing_name" {
  type = string
}

variable "vnet_inbound_name" {
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

variable "private_link_dns_zone_rg" {
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