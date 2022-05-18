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
  type        = string
  description = "Standard pci/no-pci tags"
}

variable "tsi" {
  type        = string
  description = "Tecnical service."
  default     = ""
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
  default     = "false"
}


##========================================================================================
##                                                                                      ##
## Application Service                                                                  ##
##                                                                                      ##
##========================================================================================

##──── App Service Plan ──────────────────────────────────────────────────────────────────

variable "admin_panel_name" {
  type        = string
  description = "Admin Panel app service name"
}

variable "batch_name" {
  type        = string
  description = "Batch app service name"
}

variable "logging_name" {
  type        = string
  description = "Logging app service name"
}

variable "restapi_io_name" {
  type        = string
  description = "Admin Panel app service name"
}

variable "restapi_name" {
  type        = string
  description = "Admin Panel app service name"
}

variable "rtd_name" {
  type        = string
  description = "Rtd app service name"
}

variable "wisp_name" {
  type        = string
  description = "wisp app service name"
}

variable "plan_name" {
  type        = string
  description = "app service plan name"
}

variable "unique_plan_name" {
  type        = string
  description = "Unique app service plan name"
}

variable "payment_gateway_name" {
  type        = string
  description = "payment gatewa app service name"
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

variable "spring_profile" {
  type        = string
  description = "Select active spring profile"
}

variable "hostname" {
  type = string
}
variable "hostname_rtd" {
  type = string
}
variable "static_hostname" {
  type = string
}

variable "apim_context_root" {
  type = string
}

variable "nodo_spc_hostname" {
  type = string
}
variable "cittadinanza_hostname" {
  type = string
}
variable "jiffy_hostname" {
  type = string
}
variable "logging_white_list" {
  type = string
}
variable "bancomat_keystore_location" {
  type = string
}
variable "cors_allowed_origins" {
  type = string
}

variable "secret_key_store_path" {
  type = string
}

variable "crypto_private_server_key_path" {
  type = string
}

variable "crypto_public_server_key_path" {
  type = string
}

variable "jvm_route" {
  type = string
}

variable "bancomatPay_client_group_code" {
  type = string
}

variable "bancomatPay_client_institute_code" {
  type = string
}

variable "bancomatPay_client_tag" {
  type = string
}

variable "bancomatPay_client_token" {
  type = string
}

variable "bancomatPay_client_url" {
  type = string
}

variable "bancomatPay_client_timeout_ms" {
  type = string
}

variable "bancomatpay_session_timeout_s" {
  type = string
}

variable "base_path_payment_gateway" {
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

##========================================================================================
##                                                                                      ##
##                                  Application Insight                                 ##
##                                                                                      ##
##========================================================================================

##──── Application Insight Variable ──────────────────────────────────────────────────────
variable "appinsight_name" {
  type        = string
  description = "Application insight name"
}

variable "appinsight_rg" {
  type        = string
  description = "Application insight resource group"
}

variable "appinsight_instrumentation_key" {
  type        = string
  description = "Instrumentation key var for manual connection"
}

variable "appinsight_connection_string" {
  type        = string
  description = "Connection string var for manual connection"
}