##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "U87-PM-AppServices-pci-uat"
location = "westeurope"
environment = "uat"
standard = "pci"

##──── Network configuration variables ───────────────────────────────────────────────────
# Network resource
network_resource = "U87-NetworkResources-pci-uat"

# VNET reference
vnet_name = "U87_UAT_APPSERVICES_VNET_PCI"

# Integration subnet
subnet_name = "pm-appgw-subnet-pci"

# Private inbound connection
inboundsubnet_name = "pm-inbound-subnet"

# Private link dns zone
private_link_dns_zone = "privatelink.azurewebsites.net"


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

