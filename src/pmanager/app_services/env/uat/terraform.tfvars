##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "U87-PM-AppServices-pci-uat"
location = "westeurope"
environment = "uat"

##──── App service definition plan ───────────────────────────────────────────────────────
plan_sku = "P1v3"
plan_sku_tier = "PremiumV3"
plan_kind = "Linux"
plan_reserved = "true"
app_command_line = "/home/site/deployments/tools/startup_script.sh"

##──── JAVA OPTS ─────────────────────────────────────────────────────────────────────────
java_opts = "-Dfile.encoding=UTF-8 -Ddandelion.profile.active=prod -Dcom.sun.jersey.server.impl.cdi.lookupExtensionInBeanManager=true"


##──── SYSTEM ENCODING ───────────────────────────────────────────────────────────────────
system_encoding = "C.UTF-8"


##──── WEBSITE HTTP LOGGING RETENTION DAYS ───────────────────────────────────────────────
http_log_retention_days = 7


##──── APP Service runtime config ────────────────────────────────────────────────────────
runtime_name = "jbosseap"
runtime_version = "7-java8"


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


##──── Key vault variables ───────────────────────────────────────────────────────────────
## Key vault name
key_vault = "U87-KMN-PM-uat-pci"

## Key vault resource group
key_vault_rg = "U87-KMN-VaultResources-uat-pci"


##──── Application Insight Variable ──────────────────────────────────────────────────────
appinsight_name = "U87-PagoPa-pci-uat-insight"

appinsight_rg = "U87-Monitoring"