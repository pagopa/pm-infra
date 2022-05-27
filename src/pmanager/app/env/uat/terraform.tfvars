##──── Global azure object ───────────────────────────────────────────────────────────────
rg = "U87-PM-AppServices-pci-uat"
location = "westeurope"
environment = "uat"
standard = "pci"
tsi = "TS00555"
prefix = "U87"

##──── App service definition plan ───────────────────────────────────────────────────────
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
plan_name = "plan-pci"
unique_plan_name = "pm-appservices-pci"

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
hostname = "https://api.uat.platform.pagopa.it"
hostname_rtd = "https://api.uat.platform.pagopa.it"
static_hostname = "https://acardste.vaservices.eu/"
nodo_spc_hostname = "https://api.uat.platform.pagopa.it/nodo/nodo-per-pm/v1"
apim_context_root = "payment-manager"

##──── Other variables ───────────────────────────────────────────────────────────────────
cittadinanza_hostname = "https://app-backend.io.italia.it/"
jiffy_hostname = "https://app-te.vaservices.eu/p2penginectx/F1/services/ConsultazioneCrossServices"
logging_white_list = "permitAll"
bancomat_keystore_location = "/home/site/appconfig/Bancomat/certificati/keyBancomat.jks"
cors_allowed_origins = "https://uat.checkout.pagopa.it"
spring_profile = "uat-azure"
secret_key_store_path = "/home/site/appconfig/userData/userKeys/"
crypto_private_server_key_path = "/home/site/appconfig/userData/serverKeys/privateKey.pem"
crypto_public_server_key_path = "/home/site/appconfig/userData/serverKeys/publicKey.pem"
jvm_route = "uat-agid01"

##──── Payment gateway base path ─────────────────────────────────────────────────────────
base_path_payment_gateway = "/payment-gateway/v1"

##──── Payment gateway vars ──────────────────────────────────────────────────────────────
bancomatPay_client_group_code = "12928"
bancomatPay_client_institute_code = "12928"
bancomatPay_client_tag = "VB573BC"
bancomatPay_client_token = "Pa8UiKAoWqdeqtjqJmaX7n1jKLMPwqsbAa4nkVCrupKU2yb0bq"
bancomatPay_client_url = "https://app-te.vaservices.eu:446/p2b-enginectx/services/PagoPaServices"
bancomatPay_client_timeout_ms = "5000"
bancomatpay_session_timeout_s = "60"

##──── Application Insight Variable ──────────────────────────────────────────────────────
appinsight_name = "U87-PagoPa-pci-uat-insight"

appinsight_rg = "U87-Monitoring"

# Appinsight instrumentation key manual connection
# set this two var for set manual connection
appinsight_instrumentation_key = ""
appinsight_connection_string = ""

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

##──── Application Gateway variables ─────────────────────────────────────────────────────
## APPGTW Resource group
appgw_rg = "U87-AppGateway-pci-uat"
appgw_context = ["uat", "pft"]
appgw_name = "pm-appgw"
backend_address_pool_name = "pm-jboss"
backend_http_settings_host_name = "ddsappservices-pm.azurewebsites.net"
appgw_subnet_name = "pm-appgw"
appgw_sku_size = "WAF_Medium"
appgw_sku_capacity = "1"

##──── Key vault variables ───────────────────────────────────────────────────────────────
## Key vault name
key_vault = "U87-KMN-PM-uat-pci"

## Key vault resource group
key_vault_rg = "U87-KMN-VaultResources-uat-pci"
