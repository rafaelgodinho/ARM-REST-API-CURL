#!/bin/bash

declare subscriptionId=""
declare tenantId=""
declare clientId=""
declare clientSecret=""

while getopts ":i:t:c:s:" arg; do
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
		esac
done
shift $((OPTIND-1))

url="https://login.microsoftonline.com/$tenantId/oauth2/token"
contentType="application/x-www-form-urlencoded"
body="grant_type=client_credentials&client_id=$clientId&client_secret=$clientSecret&resource=https%3A%2F%2Fmanagement.azure.com%2F"

token=$(curl --silent -H $contentType -X POST -d $body $url)

#return access_token
echo $token | jq .access_token | tr -d '"'