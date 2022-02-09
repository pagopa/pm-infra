##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "U87-PM-AppServices-pci-uat"
location = "westeurope"
environment = "uat"
standard = "pci"

##──── App service definition plan ───────────────────────────────────────────────────────
plan_sku = "P1v3"
plan_sku_tier = "PremiumV3"
plan_kind = "Linux"
plan_reserved = "true"

# Apps services name
admin_panel_name = "pm-appsrv-admin-panel"
batch_name = "pm-appsrv-batch"
logging_name = "pm-appsrv-logging"
restapi_io_name = "pm-appsrv-restapi-io"
restapi_name = "pm-appsrv-restapi"
rtd_name = "pm-appsrv-rtd"
wisp_name = "pm-appsrv-wisp"

# App service plan
plan_name = "plan-pci"

##──── JAVA OPTS ─────────────────────────────────────────────────────────────────────────
java_opts = "-Dfile.encoding=UTF-8 -Ddandelion.profile.active=prod -Dcom.sun.jersey.server.impl.cdi.lookupExtensionInBeanManager=true"

##──── SYSTEM ENCODING ───────────────────────────────────────────────────────────────────
system_encoding = "C.UTF-8"

##──── WEBSITE HTTP LOGGING RETENTION DAYS ───────────────────────────────────────────────
http_log_retention_days = 7

##──── APP Service runtime config ────────────────────────────────────────────────────────
runtime_name = "jbosseap"
runtime_version = "7-java8"

hostname = ""
hostname_rtd = ""
static_hostname = ""
nodo_spc_hostname = ""
cittadinanza_hostname = ""
jiffy_hostname = ""
logging_white_list = ""
bancomat_keystore_location = ""
cors_allowed_origins = ""

##──── Application Insight Variable ──────────────────────────────────────────────────────
appinsight_name = "U87-PagoPa-pci-uat-insight"

appinsight_rg = "U87-Monitoring"

# Appinsight instrumentation key manual connection
# set this two var for set manual connection
appinsight_instrumentation_key = ""
appinsight_connection_string = ""

##──── Network configuration variables ───────────────────────────────────────────────────
# Network resource
network_resource = "U87-NetworkResources-pci-uat"

## VNET reference
# outgoing
vnet_outgoing_name = "U87_UAT_APPSERVICES_VNET_PCI"

# inbound 
vnet_inbound_name = "U87_UAT_APPSERVICES_INBOUND_VNET_PCI"

# Integration subnet
subnet_name = "pm-subnet"

# Private inbound connection
inboundsubnet_name = "default"

# Private link dns zone
private_link_dns_zone = "privatelink.azurewebsites.net"

# Private link dns zone resource group
private_link_dns_zone_rg = "U87-NetworkResources-pci-uat"

##──── Application Gateway variables ─────────────────────────────────────────────────────
## APPGTW Resource group
appgw_rg = "U87-PM-ApplicationGateway-pci-uat"
appgw_name = "pm-appgw"
backend_address_pool_name = "pm-jboss"
backend_http_settings_host_name = "ddsappservices-pm.azurewebsites.net"
appgw_subnet_name = "pm-appgtw"
appgw_sku_size = "WAF_v2"
appgw_sku_capacity = "1"

##──── Key vault variables ───────────────────────────────────────────────────────────────
## Key vault name
key_vault = "U87-KMN-PM-uat-pci"

## Key vault resource group
key_vault_rg = "U87-KMN-VaultResources-uat-pci"
