#!/bin/bash
subscriptionId="<TODO>"
tenantId="<TODO>"
clientId="<TODO>"
clientSecret="<TODO>"
resourceGroupName="<TODO>"
vmssName="<TODO>"

./getVMSSPublicIP.sh -i $subscriptionId -t $tenantId -c $clientId -s $clientSecret -g $resourceGroupName -v $vmssName