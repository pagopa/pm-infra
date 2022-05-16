#!/bin/bash

if [[ "$(ls ./env)" =~ "$1" ]] && [ "$1" != "" ]; then
    ./terraform.sh apply $1 \
        -target=data.azurerm_resource_group.vmrg \
        -target=data.azurerm_resource_group.rg_vnet \
        -target=data.azurerm_virtual_network.vm_vnet \
        -target=data.azurerm_subnet.vm_subnet \
        -target=azurerm_network_interface.vm_nic \
        -target=azurerm_key_vault_secret.sshkey \
        -target=azurerm_linux_virtual_machine.vm

    if (( $? == 0 )); then
        ./terraform.sh apply $1
    fi
else
    echo "Please select env from:\n$( ls -1 ./env )"
fi
