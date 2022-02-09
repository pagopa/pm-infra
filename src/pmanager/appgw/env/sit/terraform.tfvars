##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "PM-AppServices"
location = "westeurope"
environment = "sit"
standard = "no-pci"

##──── Network configuration variables ───────────────────────────────────────────────────
# Network resource
network_resource = "DDS-NetworkResources"

# VNET reference
vnet_name = "DDS_SIT_APPSERVICES_VNET"

# Integration subnet
subnet_name = "pm-subnet"

# Private inbound connection
inboundsubnet_name = "pm-inbound-subnet"

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
appgw_sku_capacity = "1"


##──── Key vault variables ───────────────────────────────────────────────────────────────
## Key vault name
key_vault = "KMN-PM-Pagopa-Test"

## Key vault resource group
key_vault_rg = "KMN-VaultResources"

