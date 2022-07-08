##──── Global azure object ───────────────────────────────────────────────────────────────
location    = "westeurope"
environment = "pft"
standard    = "pci"
tsi         = "TS00555"
prefix      = "U87-PM"

##──── Network configuration variables ───────────────────────────────────────────────────
# Network resource
network_resource = "U87-NetworkResources-pci-uat"

##──── Key vault variables ───────────────────────────────────────────────────────────────
## Key vault name
key_vault = "U87-KMN-PM-uat-pci"

## Key vault resource group
key_vault_rg = "U87-KMN-VaultResources-uat-pci"

##──── Virtual machine variables ─────────────────────────────────────────────────────────
## Virtual machine resource group
vmrg = "U87-Databases-pci-uat"

## Virtual machine name
vm_name = "ldbpmspt"

## Virtual machine count
vm_count = "2"

# Virtual machine size
vm_size = ["Standard_E20s_v5", "Standard_E4s_v5"]

# Virtual machine starter ip addr
vm_ip = "10.70.73.2"
ip_shift = 4

## Virtual machine virtual network name
vm_network_name = "U87_UAT_DATABASE_VNET_PCI"

##──── Virtual machine data disk ─────────────────────────────────────────────────────────

disk_oracle_data = {
  vgdb = {
    lun = 1
    size = "256"
    tier = "P15"
  }
  dbadmin = {
    lun = 2
    size = "256"
    tier = "P15"
  }
  reco = {
    lun = 3
    size = "256"
    tier = "P15"
  }
  data1 = {
    lun  = 4
    size = "256"
    tier = "P15"
  }
  data2 = {
    lun  = 5
    size = "256"
    tier = "P15"
  }
}

##========================================================================================
##                                                                                      ##
## Encryption Set                                                                       ##
##                                                                                      ##
##========================================================================================

##──── Encryption variables ──────────────────────────────────────────────────────────────
encset_name = "U87-KMN-NODO-ENCSET-pci-uat"
encset_rg   = "U87-ENCSET-pci-uat"

##──── -- ────────────────────────────────────────────────────────────────────────────────
##──── -- ────────────────────────────────────────────────────────────────────────────────
