##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "PM-AppServices"
location = "westeurope"
environment = "sit"

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

##──── Key vault variables ───────────────────────────────────────────────────────────────
## Key vault name
key_vault = "KMN-PM-Pagopa-Test"

## Key vault resource group
key_vault_rg = "KMN-VaultResources"

##──── Virtual machine variables ─────────────────────────────────────────────────────────
## Virtual machine resource group
vmrg = "DDS-VirtualMachines"

## Virtual machine name
vm_name = "ldbpmst"

## Virtual machine count
vm_count = "1"

# Virtual machine size
vm_size = "Standard_D4s_v3"

## Virtual machine virtual network name
vm_network_name = "U89_TEST_DATABASE"

## Virtual machine network interface
vm_nic = "ldbpmst01-nic"

##──── Virtual machine data disk ─────────────────────────────────────────────────────────
disk_oracle_vgdb_size = "200" 
disk_oracle_data_size = "100"
disk_oracle_reco_size = "30"
disk_oracle_has_size = "20"