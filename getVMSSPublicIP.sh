#!/bin/bash
declare subscriptionId=""
declare tenantId=""
declare clientId=""
declare clientSecret=""
declare resourceGroupName=""
declare vmssName=""

while getopts ":i:t:c:s:g:v:" arg; do
	case "${arg}" in
		i)
			subscriptionId=${OPTARG}
			;;
		t)
			tenantId=${OPTARG}
			;;
		c)
			clientId=${OPTARG}
			;;
		s)
			clientSecret=${OPTARG}
			;;
        g)
            resourceGroupName=${OPTARG}
            ;;
		v)
			vmssName=${OPTARG}
		esac
done
shift $((OPTIND-1))

bearerToken=$(./getBearerToken.sh -i $subscriptionId -t $tenantId -c $clientId -s $clientSecret)

curl -X "GET" "https://management.azure.com/subscriptions/$subscriptionId/resourcegroups/$resourceGroupName/providers/Microsoft.Compute/virtualMachineScaleSets/$vmssName/publicipaddresses?api-version=2017-03-30" \
    -H "Authorization: Bearer $bearerToken" \
    -H "Content-Type: application/json"