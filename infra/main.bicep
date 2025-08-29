targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'azure-bicep-templates-rg'
  location: 'eastus2'
}

module storage '../src/storage/deploy.bicep' = {
  name: 'azure-bicep-templates-storage'
  scope: resourceGroup
}

module monitor '../src/monitor/deploy.bicep' = {
  name: 'azure-bicep-templates-dashboard'
  scope: resourceGroup
}
