## Global azure object
#########################################################
environment = "uat"
location = "West Europe"


## Network configuration variables
#########################################################
# Network resource
network_resource = "U87-NetworkResources-pci-uat"

# VNET outgoing reference
vnet_outgoing_name = "U87_UAT_APPSERVICES_VNET_PCI"

# VNET outgoing reference
vnet_inbound_name = "U87_UAT_APPSERVICES_INBOUND_VNET_PCI"

# VNET database reference
vnet_database_name = "U87_UAT_DATABASE_VNET_PCI"

##──── Key vault variables ───────────────────────────────────────────────────────────────
## Key vault name
key_vault = "U87-KMN-PM-uat-pci"

## Key vault resource group
key_vault_rg = "U87-KMN-VaultResources-uat-pci"