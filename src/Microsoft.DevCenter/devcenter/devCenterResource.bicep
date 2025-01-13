@description('Dev Center name')
param name string

@description('Location')
param location string

@description('Catalog Item Sync Enable Status')
@allowed([
  'Enabled'
  'Disabled'
])
param catalogItemSyncEnableStatus string

@description('Microsoft Hosted Network Enable Status')
@allowed([
  'Enabled'
  'Disabled'
])
param microsoftHostedNetworkEnableStatus string

@description('Install Azure Monitor Agent Enable Status')
@allowed([
  'Enabled'
  'Disabled'
])
param installAzureMonitorAgentEnableStatus string

@description('Tags')
param tags object

resource devCenter 'Microsoft.DevCenter/devcenters@2024-10-01-preview' = {
  name: '${uniqueString(resourceGroup().id, name)}-devcenter'
  location: location
  tags: tags
  properties: {
    projectCatalogSettings: {
      catalogItemSyncEnableStatus: catalogItemSyncEnableStatus
    }
    networkSettings: {
      microsoftHostedNetworkEnableStatus: microsoftHostedNetworkEnableStatus
    }
    devBoxProvisioningSettings: {
      installAzureMonitorAgentEnableStatus: installAzureMonitorAgentEnableStatus
    }
  }
}
