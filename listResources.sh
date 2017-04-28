#!/bin/bash
declare subscriptionId=""
declare tenantId=""
declare clientId=""
declare clientSecret=""
declare resourceGroupName=""

while getopts ":i:t:c:s:g:" arg; do
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
		esac
done
shift $((OPTIND-1))

bearerToken=$(./getBearerToken.sh -i $subscriptionId -t $tenantId -c $clientId -s $clientSecret)

curl -X "GET" "https://management.azure.com/subscriptions/$subscriptionId/resourcegroups/$resourceGroupName/resources?api-version=2016-09-01" \
    -H "Authorization: Bearer $bearerToken" \
    -H "Content-Type: application/json"