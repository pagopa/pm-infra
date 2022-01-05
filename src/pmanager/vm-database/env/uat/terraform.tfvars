##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "U87-PM-AppServices-pci-uat"
location = "westeurope"
environment = "uat"

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

##──── Key vault variables ───────────────────────────────────────────────────────────────
## Key vault name
key_vault = "U87-KMN-PM-uat-pci"

## Key vault resource group
key_vault_rg = "U87-KMN-VaultResources-uat-pci"

##──── Virtual machine variables ─────────────────────────────────────────────────────────
## Virtual machine resource group
vmrg = "U87-VirtualMachines-pci-uat"

## Virtual machine name
vm_name = "ldbpmsa"

## Virtual machine count
vm_count = "1"

# Virtual machine size
vm_size = "Standard_D4s_v3"

## Virtual machine virtual network name
vm_network_name = "U87_UAT_DATABASE_VNET_PCI"

## Virtual machine network interface
vm_nic = "ldbpmsa01-nic"

##──── Virtual machine data disk ─────────────────────────────────────────────────────────
disk_oracle_vgdb_size = "500" 
disk_oracle_data_size = "100"
disk_oracle_reco_size = "10"
disk_oracle_has_size = "150"