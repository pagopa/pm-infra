# Github service connection (read-only)
resource "azuredevops_serviceendpoint_github" "pipeline-deploy-token-ro" {
  depends_on = [azuredevops_project.project]

  project_id            = azuredevops_project.project.id
  service_endpoint_name = "pipeline-deploy-token-ro"
  auth_personal {
    personal_access_token = module.secrets.values["pipeline-deploy-token-ro-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}

# Github service connection (pull request)
resource "azuredevops_serviceendpoint_github" "pipeline-deploy-token-pr" {
  depends_on = [azuredevops_project.project]

  project_id            = azuredevops_project.project.id
  service_endpoint_name = "pipeline-deploy-token-pr"
  auth_personal {
    personal_access_token = module.secrets.values["pipeline-deploy-token-pr-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}

# Github service connection (read/write)
resource "azuredevops_serviceendpoint_github" "pipeline-deploy-token-rw" {
  depends_on = [azuredevops_project.project]

  project_id            = azuredevops_project.project.id
  service_endpoint_name = "pipeline-deploy-token-rw"
  auth_personal {
    personal_access_token = module.secrets.values["pipeline-deploy-token-rw-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}


# DEV service connection
#resource "azuredevops_serviceendpoint_azurerm" "DEV-PM" {
#  depends_on = [azuredevops_project.project]
#
#  project_id                = azuredevops_project.project.id
#  service_endpoint_name     = "DEV-PM-SERVICE-CONN"
#  description               = "DEV-PM Service connection"
#  azurerm_subscription_name = "DEV-PM"
#  azurerm_spn_tenantid      = module.secrets.values["TENANTID"].value
#  azurerm_subscription_id   = module.secrets.values["DEV-PM-SUBSCRIPTION-ID"].value
#}

# UAT service connection
resource "azuredevops_serviceendpoint_azurerm" "UAT-PM" {
  depends_on = [azuredevops_project.project]

  project_id                = azuredevops_project.project.id
  service_endpoint_name     = "UAT-PM-SERVICE-CONN"
  description               = "UAT-PM Service connection"
  azurerm_subscription_name = "UAT-PM"
  azurerm_spn_tenantid      = module.secrets.values["TENANTID"].value
  azurerm_subscription_id   = module.secrets.values["UAT-PM-SUBSCRIPTION-ID"].value
}

# PROD service connection
#resource "azuredevops_serviceendpoint_azurerm" "PROD-PM" {
#  depends_on = [azuredevops_project.project]
#
#  project_id                = azuredevops_project.project.id
#  service_endpoint_name     = "PROD-PM-SERVICE-CONN"
#  description               = "PROD-PM Service connection"
#  azurerm_subscription_name = "PROD-PM"
#  azurerm_spn_tenantid      = module.secrets.values["TENANTID"].value
#  azurerm_subscription_id   = module.secrets.values["PROD-PM-SUBSCRIPTION-ID"].value
#}
