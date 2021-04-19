
#!/bin/bash

resourceGroup=$1
location=$2

az login

echo "Create resource group $resourceGroup in $location"
az group create --name $resourceGroup --location $location > /dev/null

echo "Create FreePlan Application Plan"
$plan = (az appservice plan create --resource-group $resourceGroup --name FreePlan --sku FREE > /dev/null
uuid=$(uuidgen)
uuid=$(echo ${uuid//-/})
siteName = "game-" + $uuid

echo "Create Web App"
az webapp create --name $siteName --plan FreePlan --resource-group $resourceGroup  --runtime "php|7.2" > /dev/null

echo "Copy Publish Profile to Github secret --> AZUREWEBAPPPUBLISHPROFILE"
az webapp deployment list-publishing-profiles -g $resourceGroup -n $siteName --xml --output tsv