terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "=3.1.0"
    }
  }
}

resource "null_resource" "this" {
  # needs az cli > 2.0.81
  # see https://github.com/Azure/azure-cli/issues/12152

  triggers = {
    name                = "pmagent-pool-uat"
    resource_group_name = "U87-ScaleSets"
    subscription        = "U87-PagoPa-PCI-uat"
  }

  provisioner "local-exec" {
    command = <<EOT
        az account show && df -h && who
    EOT
  }
}