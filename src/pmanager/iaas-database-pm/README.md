<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.99.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.99.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.sshkey](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.oracle_data](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.vm_nic](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_data_disk_attachment.oracle_data](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/client_config) | data source |
| [azurerm_disk_encryption_set.encset](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/disk_encryption_set) | data source |
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.admin-password](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.admin-user](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.vmrg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.vm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vm_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_oracle_data"></a> [disk\_oracle\_data](#input\_disk\_oracle\_data) | Oracle data disk size and sku. | `map(map(string))` | n/a | yes |
| <a name="input_encset_name"></a> [encset\_name](#input\_encset\_name) | Encryption set name. | `string` | n/a | yes |
| <a name="input_encset_rg"></a> [encset\_rg](#input\_encset\_rg) | Encryption set resource group. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_ip_shift"></a> [ip\_shift](#input\_ip\_shift) | Shift ip address creation | `number` | n/a | yes |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | Key Vault name | `string` | n/a | yes |
| <a name="input_key_vault_rg"></a> [key\_vault\_rg](#input\_key\_vault\_rg) | Key Vault resource group | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location to deploy the resoruce group | `string` | `"westeurope"` | no |
| <a name="input_network_resource"></a> [network\_resource](#input\_network\_resource) | # Network resource | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Project prefix on all resources. | `string` | n/a | yes |
| <a name="input_standard"></a> [standard](#input\_standard) | Standard PCI or no-PCI | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_tsi"></a> [tsi](#input\_tsi) | Tecnical service | `string` | n/a | yes |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | Virtual machine count | `string` | n/a | yes |
| <a name="input_vm_ip"></a> [vm\_ip](#input\_vm\_ip) | Virtual machine starter ip subnet | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Virtual machine name | `string` | n/a | yes |
| <a name="input_vm_network_name"></a> [vm\_network\_name](#input\_vm\_network\_name) | Virtual machine network name | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Virtual machines list of size, set sequence of all vm. | `list(string)` | n/a | yes |
| <a name="input_vmrg"></a> [vmrg](#input\_vmrg) | Virtual machine resource group | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
