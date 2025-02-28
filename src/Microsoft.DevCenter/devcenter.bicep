@description('Dev Center Settings')
param settings Settings

@description('Dev Center Identity')
param identity Identity

@description('Dev Center Catalogs')
param catalogs Catalog

@description('Dev Center Settings')
type Settings = {
  name: string
  location: string
  catalogItemSyncEnableStatus: string
  microsoftHostedNetworkEnableStatus: string
  installAzureMonitorAgentEnableStatus: string
}

@description('Dev Center Identity')
type Identity = {
  type: string
}

type Catalog = [
  {
    name: string
    path: string
    sync: bool
  }
]

@description('Dev Center Resource')
resource devcenter 'Microsoft.DevCenter/devcenters@2024-10-01-preview' = {
  name: settings.name
  location: settings.location
  properties: {
    projectCatalogSettings: {
      catalogItemSyncEnableStatus: settings.catalogItemSyncEnableStatus
    }
    networkSettings: {
      microsoftHostedNetworkEnableStatus: settings.microsoftHostedNetworkEnableStatus
    }
    devBoxProvisioningSettings: {
      installAzureMonitorAgentEnableStatus: settings.installAzureMonitorAgentEnableStatus
    }
  }
  identity: {
    type: identity.type
  }
}

output name string = devcenter.name
output location string = devcenter.location
output catalogItemSyncEnableStatus string = devcenter.properties.projectCatalogSettings.catalogItemSyncEnableStatus
output microsoftHostedNetworkEnableStatus string = devcenter.properties.networkSettings.microsoftHostedNetworkEnableStatus
output installAzureMonitorAgentEnableStatus string = devcenter.properties.devBoxProvisioningSettings.installAzureMonitorAgentEnableStatus
