variable "iac" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "pm-infra"
      branch_name     = "main"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
    }
  }
}

locals {
  # global vars
  iac-variables = {

  }
  # global secrets
  iac-variables_secret = {

  }

  # code_review vars
  iac-variables_code_review = {

  }
  # code_review secrets
  iac-variables_secret_code_review = {

  }

  # deploy vars
  iac-variables_deploy = {

  }
  # deploy secrets
  iac-variables_secret_deploy = {

  }
}

module "iac_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v1.0.0"
  count  = var.iac.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = azuredevops_project.project.id
  repository                   = var.iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.pipeline-deploy-token-rw.id

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.iac-variables,
    local.iac-variables_code_review,
  )

  variables_secret = merge(
    local.iac-variables_secret,
    local.iac-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.pipeline-deploy-token-ro.id,
    azuredevops_serviceendpoint_azurerm.UAT-PM.id,
  ]
}

module "iac_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v1.0.0"
  count  = var.iac.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = azuredevops_project.project.id
  repository                   = var.iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.pipeline-deploy-token-rw.id

  ci_trigger_use_yaml = true

  variables = merge(
    local.iac-variables,
    local.iac-variables_deploy,
  )

  variables_secret = merge(
    local.iac-variables_secret,
    local.iac-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.pipeline-deploy-token-ro.id,
    azuredevops_serviceendpoint_azurerm.UAT-PM.id,
  ]
}

    #azuredevops_serviceendpoint_azurerm.DEV-PM.id,
    #azuredevops_serviceendpoint_azurerm.PROD-PM.id,
