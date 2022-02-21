module "secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v1.0.11"

  resource_group = local.key_vault_resource_group
  key_vault_name = local.key_vault_name

  secrets = [
    "pipeline-deploy-token-pr-TOKEN",
    "pipeline-deploy-token-rw-TOKEN",
    "pipeline-deploy-token-ro-TOKEN",
    "TENANTID",
    "DEV-PM-SUBSCRIPTION-ID",
    "UAT-PM-SUBSCRIPTION-ID",
    "PROD-PM-SUBSCRIPTION-ID",
  ]
}
