@description('Dev Center Settings')
param settings Settings

@description('Dev Center Identity')
param identity Identity

@description('Cataglogs')
param catalogs Catalog[]

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
  type: IdentityType
}

type IdentityType = 'SystemAssigned' | 'UserAssigned' | 'None' | 'SystemAssigned, UserAssigned'

@description('Cataglogs')
type Catalog = {
  name: string
  type: CatalogType
  uri: string
  branch: string
  path: string
}

type CatalogType = 'gitHub' | 'adoGit'

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

@description('Dev Center Catalogs')
module devCenterCatalogs 'catalog.bicep' = [
  for catalog in catalogs: {
    name: 'catalog-${catalog.name}'
    scope: resourceGroup()
    params: {
      name: catalog.name
      branch: catalog.branch
      devCenterName: devcenter.name
      path: catalog.path
      type: catalog.type
      uri: catalog.uri
    }
  }
]

output catalogs array = [
  for (catalog, i) in catalogs: {
    name: devCenterCatalogs[i].outputs.name
    type: devCenterCatalogs[i].outputs.type
    uri: devCenterCatalogs[i].outputs.uri
    branch: devCenterCatalogs[i].outputs.branch
  }
]
