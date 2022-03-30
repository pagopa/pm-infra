# Payment Manager App Services

Terraform payment manager provisiong repository for Big Data & Cloud Development
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.94.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.94.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_admin-panel"></a> [admin-panel](#module\_admin-panel) | git::https://github.com/pagopa/azurerm.git//app_service | app-service-storage-mounts |
| <a name="module_batch"></a> [batch](#module\_batch) | git::https://github.com/pagopa/azurerm.git//app_service | app-service-storage-mounts |
| <a name="module_logging"></a> [logging](#module\_logging) | git::https://github.com/pagopa/azurerm.git//app_service | app-service-storage-mounts |
| <a name="module_payment-gateway"></a> [payment-gateway](#module\_payment-gateway) | git::https://github.com/pagopa/azurerm.git//app_service | app-service-storage-mounts |
| <a name="module_restapi"></a> [restapi](#module\_restapi) | git::https://github.com/pagopa/azurerm.git//app_service | app-service-storage-mounts |
| <a name="module_restapi-io"></a> [restapi-io](#module\_restapi-io) | git::https://github.com/pagopa/azurerm.git//app_service | app-service-storage-mounts |
| <a name="module_rtd"></a> [rtd](#module\_rtd) | git::https://github.com/pagopa/azurerm.git//app_service | app-service-storage-mounts |
| <a name="module_wisp"></a> [wisp](#module\_wisp) | git::https://github.com/pagopa/azurerm.git//app_service | app-service-storage-mounts |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_slot.admin-panel-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot) | resource |
| [azurerm_app_service_slot.batch-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot) | resource |
| [azurerm_app_service_slot.logging-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot) | resource |
| [azurerm_app_service_slot.payment-gateway-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot) | resource |
| [azurerm_app_service_slot.restapi-io-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot) | resource |
| [azurerm_app_service_slot.restapi-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot) | resource |
| [azurerm_app_service_slot.rtd-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot) | resource |
| [azurerm_app_service_slot.wisp-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot) | resource |
| [azurerm_app_service_slot_virtual_network_swift_connection.admin-panel-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot_virtual_network_swift_connection) | resource |
| [azurerm_app_service_slot_virtual_network_swift_connection.batch-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot_virtual_network_swift_connection) | resource |
| [azurerm_app_service_slot_virtual_network_swift_connection.logging-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot_virtual_network_swift_connection) | resource |
| [azurerm_app_service_slot_virtual_network_swift_connection.payment-gateway-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot_virtual_network_swift_connection) | resource |
| [azurerm_app_service_slot_virtual_network_swift_connection.restapi-io-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot_virtual_network_swift_connection) | resource |
| [azurerm_app_service_slot_virtual_network_swift_connection.restapi-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot_virtual_network_swift_connection) | resource |
| [azurerm_app_service_slot_virtual_network_swift_connection.rtd-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot_virtual_network_swift_connection) | resource |
| [azurerm_app_service_slot_virtual_network_swift_connection.wisp-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_slot_virtual_network_swift_connection) | resource |
| [azurerm_app_service_virtual_network_swift_connection.admin-panel](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_app_service_virtual_network_swift_connection.batch](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_app_service_virtual_network_swift_connection.logging](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_app_service_virtual_network_swift_connection.payment-gateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_app_service_virtual_network_swift_connection.restapi](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_app_service_virtual_network_swift_connection.restapi-io](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_app_service_virtual_network_swift_connection.rtd](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_app_service_virtual_network_swift_connection.wisp](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_private_dns_a_record.admin-panel](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.admin-panel-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.admin-panel-scm](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.admin-panel-scm-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.batch](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.batch-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.batch-scm](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.batch-scm-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.logging](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.logging-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.logging-scm](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.logging-scm-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.payment-gateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.payment-gateway-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.payment-gateway-scm](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.payment-gateway-scm-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.restapi](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.restapi-io](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.restapi-io-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.restapi-io-scm](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.restapi-io-scm-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.restapi-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.restapi-scm](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.restapi-scm-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.rtd](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.rtd-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.rtd-scm](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.rtd-scm-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.wisp](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.wisp-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.wisp-scm](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.wisp-scm-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.admin-panel](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.admin-panel-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.batch](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.batch-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.logging](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.logging-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.payment-gateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.payment-gateway-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.restapi](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.restapi-io](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.restapi-io-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.restapi-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.rtd](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.rtd-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.storage-endpt](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.wisp](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.wisp-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_account) | resource |
| [azurerm_storage_share.storage-appconfig](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share) | resource |
| [azurerm_storage_share.storage-tools](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share) | resource |
| [azurerm_storage_share_directory.appconfig-admin-panel](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-admin-panel-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-batch](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-batch-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-logging](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-logging-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-restapi](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-restapi-io](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-restapi-io-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-restapi-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-rtd](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-rtd-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-wisp](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.appconfig-wisp-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-admin-panel](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-admin-panel-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-batch](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-batch-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-logging](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-logging-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-restapi](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-restapi-io](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-restapi-io-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-restapi-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-rtd](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-rtd-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-wisp](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_storage_share_directory.tools-wisp-release](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/storage_share_directory) | resource |
| [azurerm_subnet.admin-panel](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/subnet) | resource |
| [azurerm_subnet.batch](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/subnet) | resource |
| [azurerm_subnet.logging](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/subnet) | resource |
| [azurerm_subnet.payment-gateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/subnet) | resource |
| [azurerm_subnet.restapi](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/subnet) | resource |
| [azurerm_subnet.restapi-io](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/subnet) | resource |
| [azurerm_subnet.rtd](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/subnet) | resource |
| [azurerm_subnet.wisp](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/resources/subnet) | resource |
| [azurerm_application_insights.appinsight](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/application_insights) | data source |
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.admin-panel-outgoing-subnet-address-space](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.apim-public-ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.appgw-private-ip-address](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.appgw-subnet-address-space](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.bancomat-keystore-password](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.batch-outgoing-subnet-address-space](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.event-reg-oracle-connection-url](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.log-interceptor-pattern](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.logging-outgoing-subnet-address-space](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.oracle-connection-url](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.oracle-server-agid-user](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.oracle-server-agid-user-password](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.oracle-server-event-reg-user](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.oracle-server-event-reg-user-password](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.oracle-server-rtd-user](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.oracle-server-rtd-user-password](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.payment-gateway-outgoing-subnet-address-space](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pm-api-key](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.restapi-io-outgoing-subnet-address-space](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.restapi-outgoing-subnet-address-space](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.rtd-outgoing-subnet-address-space](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.wisp-outgoing-subnet-address-space](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_private_dns_zone.zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.inboundsubnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_outgoing](https://registry.terraform.io/providers/hashicorp/azurerm/2.94.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_panel_name"></a> [admin\_panel\_name](#input\_admin\_panel\_name) | Admin Panel app service name | `string` | n/a | yes |
| <a name="input_apim_context_root"></a> [apim\_context\_root](#input\_apim\_context\_root) | n/a | `string` | n/a | yes |
| <a name="input_app_command_line"></a> [app\_command\_line](#input\_app\_command\_line) | Provide an optional startup command that will be run as part of container startup. | `string` | `""` | no |
| <a name="input_appgw_name"></a> [appgw\_name](#input\_appgw\_name) | Application gateway name | `string` | n/a | yes |
| <a name="input_appgw_rg"></a> [appgw\_rg](#input\_appgw\_rg) | Application gateway reource group | `string` | n/a | yes |
| <a name="input_appgw_sku_capacity"></a> [appgw\_sku\_capacity](#input\_appgw\_sku\_capacity) | # Sku capacity | `string` | n/a | yes |
| <a name="input_appgw_sku_size"></a> [appgw\_sku\_size](#input\_appgw\_sku\_size) | # Sku size | `string` | n/a | yes |
| <a name="input_appgw_subnet_name"></a> [appgw\_subnet\_name](#input\_appgw\_subnet\_name) | # Subnet name | `string` | n/a | yes |
| <a name="input_appinsight_connection_string"></a> [appinsight\_connection\_string](#input\_appinsight\_connection\_string) | Connection string var for manual connection | `string` | n/a | yes |
| <a name="input_appinsight_instrumentation_key"></a> [appinsight\_instrumentation\_key](#input\_appinsight\_instrumentation\_key) | Instrumentation key var for manual connection | `string` | n/a | yes |
| <a name="input_appinsight_name"></a> [appinsight\_name](#input\_appinsight\_name) | Application insight name | `string` | n/a | yes |
| <a name="input_appinsight_rg"></a> [appinsight\_rg](#input\_appinsight\_rg) | Application insight resource group | `string` | n/a | yes |
| <a name="input_backend_address_pool_name"></a> [backend\_address\_pool\_name](#input\_backend\_address\_pool\_name) | #  Backend address pool NAME | `string` | n/a | yes |
| <a name="input_backend_http_settings_host_name"></a> [backend\_http\_settings\_host\_name](#input\_backend\_http\_settings\_host\_name) | # backend HTTP settings host name | `string` | n/a | yes |
| <a name="input_bancomatPay_client_group_code"></a> [bancomatPay\_client\_group\_code](#input\_bancomatPay\_client\_group\_code) | n/a | `string` | n/a | yes |
| <a name="input_bancomatPay_client_institute_code"></a> [bancomatPay\_client\_institute\_code](#input\_bancomatPay\_client\_institute\_code) | n/a | `string` | n/a | yes |
| <a name="input_bancomatPay_client_tag"></a> [bancomatPay\_client\_tag](#input\_bancomatPay\_client\_tag) | n/a | `string` | n/a | yes |
| <a name="input_bancomatPay_client_timeout_ms"></a> [bancomatPay\_client\_timeout\_ms](#input\_bancomatPay\_client\_timeout\_ms) | n/a | `string` | n/a | yes |
| <a name="input_bancomatPay_client_token"></a> [bancomatPay\_client\_token](#input\_bancomatPay\_client\_token) | n/a | `string` | n/a | yes |
| <a name="input_bancomatPay_client_url"></a> [bancomatPay\_client\_url](#input\_bancomatPay\_client\_url) | n/a | `string` | n/a | yes |
| <a name="input_bancomat_keystore_location"></a> [bancomat\_keystore\_location](#input\_bancomat\_keystore\_location) | n/a | `string` | n/a | yes |
| <a name="input_batch_name"></a> [batch\_name](#input\_batch\_name) | Batch app service name | `string` | n/a | yes |
| <a name="input_cittadinanza_hostname"></a> [cittadinanza\_hostname](#input\_cittadinanza\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_cors_allowed_origins"></a> [cors\_allowed\_origins](#input\_cors\_allowed\_origins) | n/a | `string` | n/a | yes |
| <a name="input_crypto_private_server_key_path"></a> [crypto\_private\_server\_key\_path](#input\_crypto\_private\_server\_key\_path) | n/a | `string` | n/a | yes |
| <a name="input_crypto_public_server_key_path"></a> [crypto\_public\_server\_key\_path](#input\_crypto\_public\_server\_key\_path) | n/a | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the deployment environment | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_hostname_rtd"></a> [hostname\_rtd](#input\_hostname\_rtd) | n/a | `string` | n/a | yes |
| <a name="input_http_log_retention_days"></a> [http\_log\_retention\_days](#input\_http\_log\_retention\_days) | n/a | `string` | n/a | yes |
| <a name="input_inboundsubnet_name"></a> [inboundsubnet\_name](#input\_inboundsubnet\_name) | # Private endpoint subnet name | `string` | n/a | yes |
| <a name="input_java_opts"></a> [java\_opts](#input\_java\_opts) | Set encoding UTF-8 | `string` | n/a | yes |
| <a name="input_jiffy_hostname"></a> [jiffy\_hostname](#input\_jiffy\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_jvm_route"></a> [jvm\_route](#input\_jvm\_route) | n/a | `string` | n/a | yes |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | Key Vault name | `string` | n/a | yes |
| <a name="input_key_vault_rg"></a> [key\_vault\_rg](#input\_key\_vault\_rg) | Key Vault resource group | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location to deploy the resoruce group | `string` | n/a | yes |
| <a name="input_logging_name"></a> [logging\_name](#input\_logging\_name) | Logging app service name | `string` | n/a | yes |
| <a name="input_logging_white_list"></a> [logging\_white\_list](#input\_logging\_white\_list) | n/a | `string` | n/a | yes |
| <a name="input_network_resource"></a> [network\_resource](#input\_network\_resource) | # Network resource | `string` | n/a | yes |
| <a name="input_nodo_spc_hostname"></a> [nodo\_spc\_hostname](#input\_nodo\_spc\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_payment_gateway_name"></a> [payment\_gateway\_name](#input\_payment\_gateway\_name) | payment gatewa app service name | `string` | n/a | yes |
| <a name="input_plan_id"></a> [plan\_id](#input\_plan\_id) | (Optional) Specifies the external app service plan id. | `string` | `null` | no |
| <a name="input_plan_kind"></a> [plan\_kind](#input\_plan\_kind) | The sku kind of app service plan to create. (ES. Linux, Windows) | `string` | n/a | yes |
| <a name="input_plan_name"></a> [plan\_name](#input\_plan\_name) | app service plan name | `string` | n/a | yes |
| <a name="input_plan_reserved"></a> [plan\_reserved](#input\_plan\_reserved) | (Optional) Is this App Service Plan Reserved. Defaults to false. | `string` | `"true"` | no |
| <a name="input_plan_sku"></a> [plan\_sku](#input\_plan\_sku) | The sku of app service plan to create | `string` | n/a | yes |
| <a name="input_plan_sku_tier"></a> [plan\_sku\_tier](#input\_plan\_sku\_tier) | The sku tier of app service plan to create | `string` | n/a | yes |
| <a name="input_private_link_dns_zone"></a> [private\_link\_dns\_zone](#input\_private\_link\_dns\_zone) | n/a | `string` | n/a | yes |
| <a name="input_private_link_dns_zone_rg"></a> [private\_link\_dns\_zone\_rg](#input\_private\_link\_dns\_zone\_rg) | n/a | `string` | n/a | yes |
| <a name="input_restapi_io_name"></a> [restapi\_io\_name](#input\_restapi\_io\_name) | Admin Panel app service name | `string` | n/a | yes |
| <a name="input_restapi_name"></a> [restapi\_name](#input\_restapi\_name) | Admin Panel app service name | `string` | n/a | yes |
| <a name="input_rg"></a> [rg](#input\_rg) | Resource group variable. | `string` | n/a | yes |
| <a name="input_rtd_name"></a> [rtd\_name](#input\_rtd\_name) | Rtd app service name | `string` | n/a | yes |
| <a name="input_runtime_name"></a> [runtime\_name](#input\_runtime\_name) | # Name | `string` | n/a | yes |
| <a name="input_runtime_version"></a> [runtime\_version](#input\_runtime\_version) | # Version | `string` | n/a | yes |
| <a name="input_secret_key_store_path"></a> [secret\_key\_store\_path](#input\_secret\_key\_store\_path) | n/a | `string` | n/a | yes |
| <a name="input_spring_profile"></a> [spring\_profile](#input\_spring\_profile) | Select active spring profile | `string` | n/a | yes |
| <a name="input_standard"></a> [standard](#input\_standard) | Standard pci/no-pci tags | `string` | n/a | yes |
| <a name="input_static_hostname"></a> [static\_hostname](#input\_static\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | # Subnet name | `string` | n/a | yes |
| <a name="input_system_encoding"></a> [system\_encoding](#input\_system\_encoding) | Set LANG encoding UTF-8 | `string` | `"C.UTF-8"` | no |
| <a name="input_tsi"></a> [tsi](#input\_tsi) | Tecnical service. | `string` | `""` | no |
| <a name="input_vnet_inbound_name"></a> [vnet\_inbound\_name](#input\_vnet\_inbound\_name) | n/a | `string` | n/a | yes |
| <a name="input_vnet_outgoing_name"></a> [vnet\_outgoing\_name](#input\_vnet\_outgoing\_name) | # VNET name | `string` | n/a | yes |
| <a name="input_wisp_name"></a> [wisp\_name](#input\_wisp\_name) | wisp app service name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->