##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "PM-AppServices"
location = "westeurope"
environment = "sit"
standard = "no-pci"
tsi = "TS00555"

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
payment_gateway_name = "pm-appsrv-payment-gateway"

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
hostname = "https://api.dev.platform.pagopa.it"
hostname_rtd = "https://api.dev.platform.pagopa.it"
static_hostname = "https://api.dev.platform.pagopa.it/"
nodo_spc_hostname = "https://api.dev.platform.pagopa.it/nodo/nodo-per-pm/v1"
apim_context_root = "payment-manager"

##──── Other variables ───────────────────────────────────────────────────────────────────
cittadinanza_hostname = "https://portal.test.pagopa.gov.it/pmmockserviceapi/"
jiffy_hostname = "https://app-te.vaservices.eu/p2penginectx/F1/services/ConsultazioneCrossServices"
logging_white_list = "permitAll"
bancomat_keystore_location = "/home/site/appconfig/Bancomat/certificati/keyBancomat.jks"
cors_allowed_origins = "https://dev.checkout.pagopa.it"
spring_profile = "sit-azure"
secret_key_store_path = "/home/site/appconfig/userKeys/"
crypto_private_server_key_path = "/home/site/appconfig/userKeys/privateKey.pem"
crypto_public_server_key_path = "/home/site/appconfig/userKeys/publicKey.pem"
jvm_route = "sit-agid01"

##──── Payment gateway vars ──────────────────────────────────────────────────────────────
bancomatPay_client_group_code = "12928"
bancomatPay_client_institute_code = "12928"
bancomatPay_client_tag = "VB573BC"
bancomatPay_client_token = "Pa8UiKAoWqdeqtjqJmaX7n1jKLMPwqsbAa4nkVCrupKU2yb0bq"
bancomatPay_client_url = "https://app-te.vaservices.eu:446/p2b-enginectx/services/PagoPaServices"
bancomatPay_client_timeout_ms = "5000"

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