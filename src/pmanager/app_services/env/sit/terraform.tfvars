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

# Apps services name
admin_panel_name = "pm-appsrv-admin-panel"
batch_name = "pm-appsrv-batch"
logging_name = "pm-appsrv-logging"
restapi_io_name = "pm-appsrv-restapi-io"
restapi_name = "pm-appsrv-restapi"
rtd_name = "pm-appsrv-rtd"
wisp_name = "pm-appsrv-wisp"

# App service plan
plan_name = "plan"

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

# Appinsight instrumentation key manual connection
# set this two var for set manual connection
appinsight_instrumentation_key = "d1142808-3ef5-484e-83fa-2d8b2fef0f87"
appinsight_connection_string = "InstrumentationKey=d1142808-3ef5-484e-83fa-2d8b2fef0f87;IngestionEndpoint=https://westeurope-3.in.applicationinsights.azure.com/"

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