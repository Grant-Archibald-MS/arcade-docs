param([string] $resourceGroup = 'Games', [string] $location = 'westus')

Write-Host "Create resource group $resourceGroup in $location"
$group = (az group create --name $resourceGroup --location $location | ConvertFrom-Json)

Write-Host "Create FreePlan Application Plan"
$plan = (az appservice plan create --resource-group $resourceGroup --name FreePlan --sku FREE | ConvertFrom-Json)
$siteName = "game-" + [GUID]::NewGuid().Guid.ToString().Replace("-","")

Write-Host "Create Web App"
$site = (az webapp create --name $siteName --plan FreePlan --resource-group $resourceGroup  --runtime "php|7.2" | ConvertFrom-Json)

Write-Host "Copy Publish Profile to Github secret --> AZUREWEBAPPPUBLISHPROFILE"
az webapp deployment list-publishing-profiles -g $resourceGroup -n $siteName --xml --output tsv