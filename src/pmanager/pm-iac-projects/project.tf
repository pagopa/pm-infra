locals {
  azure_devops_org = "sia-dds"
}

resource "azuredevops_project" "project" {
  name               = "pm-iac-projects"
  description        = "This is the DevOps project for PM IAC pipeline"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Basic"
}

resource "azuredevops_project_features" "project-features" {
  project_id = azuredevops_project.project.id
  features = {
    "boards"       = "disabled"
    "repositories" = "disabled"
    "pipelines"    = "enabled"
    "testplans"    = "disabled"
    "artifacts"    = "disabled"
  }
}
