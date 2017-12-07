#!/bin/bash

#Requirements:
#   Azure CLI 2.0
#   jq

declare subscriptionId=""
declare publisherId=""
declare offerId=""
declare planId=""

while getopts ":i:p:o:n:" arg; do
	case "${arg}" in
		i)
			subscriptionId=${OPTARG}
			;;
		p)
			publisherId=${OPTARG}
			;;
		o)
			offerId=${OPTARG}
			;;
		n)
			planId=${OPTARG}
			;;
		esac
done
shift $((OPTIND-1))

bearerToken=$(az account get-access-token | jq .accessToken -r)

#Get current term
term=$(curl -X "GET" "https://management.azure.com/subscriptions/$subscriptionId/providers/Microsoft.MarketplaceOrdering/offerTypes/virtualmachine/publishers/$publisherId/offers/$offerId/plans/$planId/agreements/current?api-version=2015-06-01" \
    -H "Authorization: Bearer $bearerToken" \
    -H "Content-Type: application/json")

#Accept the term
term=$(echo $term | jq ".properties.accepted=true" -c -r)

#Update the term
curl -X "PUT" "https://management.azure.com/subscriptions/$subscriptionId/providers/Microsoft.MarketplaceOrdering/offerTypes/virtualmachine/publishers/$publisherId/offers/$offerId/plans/$planId/agreements/current?api-version=2015-06-01" \
    -H "Authorization: Bearer $bearerToken" \
    -H "Content-Type: application/json" \
    -d $term