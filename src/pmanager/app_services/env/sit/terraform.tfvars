##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "PM-AppServices"
location = "westeurope"
environment = "sit"
standard = "no-pci"

##──── App service definition plan ───────────────────────────────────────────────────────
#name = ["pm-appsrv-wisp", "pm-appsrv-restapi", "pm-appsrv-restapi-io", "pm-appsrv-admin-panel", "pm-appsrv-batch", "pm-appsrv-logging", "pm-appsrv-rtd"]
plan_sku = "P1v3"
plan_sku_tier = "PremiumV3"
plan_kind = "Linux"
plan_reserved = "true"
app_command_line = "/home/site/deployments/tools/startup_script.sh"

# Apps services plan name
admin_panel_plan = "pm-admin-panel-plan"
batch_plan = "pm-batch-plan"
logging_plan = "pm-logging-plan"
restapi_io_plan = "pm-restapi-io-plan"
restapi_plan = "pm-restapi-plan"
rtd_plan = "pm-rtd-plan"
wisp_plan = "pm-wisp-plan"

##──── JAVA OPTS ─────────────────────────────────────────────────────────────────────────
java_opts = "-Dfile.encoding=UTF-8 -Ddandelion.profile.active=prod -Dcom.sun.jersey.server.impl.cdi.lookupExtensionInBeanManager=true"

##──── SYSTEM ENCODING ───────────────────────────────────────────────────────────────────
system_encoding = "C.UTF-8"

##──── WEBSITE HTTP LOGGING RETENTION DAYS ───────────────────────────────────────────────
http_log_retention_days = 7

##──── APP Service runtime config ────────────────────────────────────────────────────────
runtime_name = "jbosseap"
runtime_version = "7-java8"

##──── Hostname resolution variables ─────────────────────────────────────────────────────
hostname = "https://api.dev.platform.pagopa.it/"
hostname_rtd = "https://api.dev.platform.pagopa.it/"
static_hostname = "https://api.dev.platform.pagopa.it/"
nodo_spc_hostname = "https://nodo-dei-pagamenti-sit-npa-nodopagamenti.tst-npc.sia.eu"

##──── Other variables ───────────────────────────────────────────────────────────────────
cittadinanza_hostname = "https://portal.test.pagopa.gov.it/pmmockserviceapi/"
jiffy_hostname = "https://app-te.vaservices.eu/p2penginectx/F1/services/ConsultazioneCrossServices"
logging_white_list = "10.49.42.72"
bancomat_keystore_location = "/home/site/appconfig/Bancomat/certificati/keyBancomat.jks"
cors_allowed_origins = "https://checkout.pagopa.gov.it"

##──── Application Insight Variable ──────────────────────────────────────────────────────
appinsight_name = ""

appinsight_rg = "U87-Monitoring"

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