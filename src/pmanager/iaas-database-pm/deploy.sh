#!/bin/bash

CMD=$1
ENV=$2

if [[ "apply refresh plan" =~ "$CMD" ]]; then
    if [[ "$(ls ./env)" =~ "$ENV" ]] && [ "$ENV" != "" ]; then
        ./terraform.sh $CMD $ENV \
            -target=data.azurerm_resource_group.vmrg \
            -target=data.azurerm_resource_group.rg_vnet \
            -target=data.azurerm_virtual_network.vm_vnet \
            -target=data.azurerm_subnet.vm_subnet \
            -target=azurerm_network_interface.vm_nic \
            -target=azurerm_key_vault_secret.sshkey \
            -target=azurerm_linux_virtual_machine.vm

        if (( $? == 0 )); then
            ./terraform.sh $CMD $ENV
        fi
    else
        echo "Please select env from:\n$( ls -1 ./env )"
    fi
else
    echo "Action not allowed."
    exit 1
fi