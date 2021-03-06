# Terraform payment manager infra

Terraform template repository for infrastructures projects

[![Build Status](https://dev.azure.com/sia-dds/pm-iac-projects/_apis/build/status/pm-infra/pm-infra.deploy?repoName=pagopa%2Fpm-infra&branchName=main)](https://dev.azure.com/sia-dds/pm-iac-projects/_build/latest?definitionId=61&repoName=pagopa%2Fpm-infra&branchName=main)

[![Platform](https://img.shields.io/badge/Microsoft_Azure-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white)](https://img.shields.io/badge/Microsoft_Azure-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white)

[![Release](https://badgen.net/badge/release/v1.3.0/green?icon=azurepipelines)](https://badgen.net/badge/:subject/:status/:color?icon=github)

## Requirements

### 1. terraform

In order to manage the suitable version of terraform it is strongly recommended to install the following tool:

- [tfenv](https://github.com/tfutils/tfenv): **Terraform** version manager inspired by rbenv.

Once these tools have been installed, install the terraform version shown in:

- .terraform-version

After installation install terraform:

```sh
tfenv install
```

## Terraform modules

As PagoPA we build our standard Terraform modules, check available modules:

- [PagoPA Terraform modules](https://github.com/search?q=topic%3Aterraform-modules+org%3Apagopa&type=repositories)

## Apply changes

To apply changes follow the standard terraform lifecycle once the code in this repository has been changed:

```sh
terraform.sh init [dev|uat|prod]

terraform.sh plan [dev|uat|prod]

terraform.sh apply [dev|uat|prod]
```

## Terraform lock.hcl

We have both developers who work with your Terraform configuration on their Linux, macOS or Windows workstations and automated systems that apply the configuration while running on Linux.
https://www.terraform.io/docs/cli/commands/providers/lock.html#specifying-target-platforms

So we need to specify this in terraform lock providers:

```sh
terraform init

rm .terraform.lock.hcl

terraform providers lock \
  -platform=windows_amd64 \
  -platform=darwin_amd64 \
  -platform=darwin_arm64 \
  -platform=linux_amd64
```

## Precommit checks

Check your code before commit.

https://github.com/antonbabenko/pre-commit-terraform#how-to-install

```sh
pre-commit run -a
```
