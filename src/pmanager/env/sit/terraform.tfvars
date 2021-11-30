##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "PM-AppServices"
location = "West Europe"


##──── App service definition plan ───────────────────────────────────────────────────────
name = "pm-appsrv"
environment = "sit"
plan_sku = "P1v3"
plan_sku_tier = "PremiumV3"
plan_kind = "Linux"
plan_reserved = "true"
app_command_line = "/home/site/deployments/tools/startup_script.sh"


##──── App service configuration ─────────────────────────────────────────────────────────
spring_config_location = "file:///home/site/appconfig/application-ti.yml"


##──── JAVA OPTS ─────────────────────────────────────────────────────────────────────────
java_opts = "-Dfile.encoding=UTF-8 -Ddandelion.profile.active=prod"


##──── SYSTEM ENCODING ───────────────────────────────────────────────────────────────────
system_encoding = "C.UTF-8"


##──── WEBSITE HTTP LOGGING RETENTION DAYS ───────────────────────────────────────────────
http_log_retention_days = 365


##──── APP Service runtime config ────────────────────────────────────────────────────────
runtime_name = "jbosseap"
runtime_version = "7-java8"


##──── Network configuration variables ───────────────────────────────────────────────────
# Network resource
network_resource = "DDS-NetworkResources"

# VNET reference
vnet_name = "DDS_SIT_APPSERVICES_VNET"

# Integration subnet
subnet_name = "pm-subnet"

# Private endpoint connection
endpointsubnet_name = "pm-endpt-subnet"

# Private link dns zone
private_link_dns_zone = "privatelink.azurewebsites.net"


##──── Application Gateway variables ─────────────────────────────────────────────────────
## APPGTW Resource group
appgw_rg = "PM-ApplicationGateway"
appgw_name = "pm-appgw"
backend_address_pool_name = "pm-jboss"
backend_http_settings_host_name = "ddsappservices-pm.azurewebsites.net"
appgw_subnet_name = "pm-appgtw"
appgw_sku_size = "WAF_v2"


##──── Key vault variables ───────────────────────────────────────────────────────────────
## Key vault name
key_vault = "KMN-PM-Pagopa-Test"

## Key vault resource group
key_vault_rg = "KMN-VaultResources"

##──── Virtual machine variables ─────────────────────────────────────────────────────────
## Virtual machine resource group
vmrg = "DDS-VirtualMachines"

## Virtual machine name
vm_name = "ldbpmst01"

# Virtual machine size
vm_size = "Standard_D4s_v3"

## Virtual machine virtual network name
vm_network_name = "U89_TEST_DATABASE"

## Virtual machine network interface
vm_nic = "ldbpmst01-nic"