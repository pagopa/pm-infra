##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "PM-AppServices"
location = "westeurope"
environment = "sit"

##──── App service definition plan ───────────────────────────────────────────────────────
#name = ["pm-appsrv-wisp", "pm-appsrv-restapi", "pm-appsrv-restapi-io", "pm-appsrv-admin-panel", "pm-appsrv-batch", "pm-appsrv-logging", "pm-appsrv-rtd"]
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
http_log_retention_days = 45


##──── APP Service runtime config ────────────────────────────────────────────────────────
runtime_name = "jbosseap"
runtime_version = "7-java8"


##──── Network configuration variables ───────────────────────────────────────────────────
# Network resource
network_resource = "DDS-NetworkResources"

## VNET reference
# outgoing
vnet_outgoing_name = "DDS_SIT_APPSERVICES_VNET"

# inbound 
vnet_inbound_name = "DDS_SIT_APPSERVICES_INBOUND_VNET"

# Integration subnet
subnet_name = "pm-subnet"

# Private inbound connection
inboundsubnet_name = "inbound_subnet"

# Private link dns zone
private_link_dns_zone = "privatelink.azurewebsites.net"

# Private link dns zone resource group
private_link_dns_zone_rg = "dds-networkresources"


##──── Key vault variables ───────────────────────────────────────────────────────────────
## Key vault name
key_vault = "KMN-PM-Pagopa-Test"

## Key vault resource group
key_vault_rg = "KMN-VaultResources"