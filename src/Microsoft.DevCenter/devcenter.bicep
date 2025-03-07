@description('Dev Center Settings')
param settings Settings

@description('Dev Center Identity')
param identity Identity

@description('Dev Center Settings')
type Settings = {
  name: string
  location: string
  catalogItemSyncEnableStatus: string
  microsoftHostedNetworkEnableStatus: string
  installAzureMonitorAgentEnableStatus: string
  catalogs: Catalog[]
  environmentTypes: EnvironmentType[]
  projects: Project[]
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

type EnvironmentType = {
  name: string
}

type Project = {
  name: string
  description: string
  catalogs: Catalog[]
  environmentTypes: ProjectEnvironmentType[]
}

type ProjectEnvironmentType = {
  name: string
  identity: Identity
  deploymentTargetId: string
}

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
module devCenterCatalogs './settings/catalog.bicep' = [
  for catalog in settings.catalogs: {
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
  for (catalog, i) in settings.catalogs: {
    name: devCenterCatalogs[i].outputs.name
    type: devCenterCatalogs[i].outputs.type
    uri: devCenterCatalogs[i].outputs.uri
    branch: devCenterCatalogs[i].outputs.branch
  }
]

@description('Dev Center Environment Types')
module devCenterEnvironmentTypes './settings/environmentType.bicep' = [
  for environmentType in settings.environmentTypes: {
    name: 'environmentType-${environmentType.name}'
    scope: resourceGroup()
    params: {
      name: environmentType.name
      devCenterName: devcenter.name
    }
  }
]

output environmentTypes array = [
  for (environmentType, i) in settings.environmentTypes: {
    name: devCenterEnvironmentTypes[i].outputs.name
  }
]

@description('Dev Center Projects')
module devCenterProjects 'projects/project.bicep' = [
  for project in settings.projects: {
    name: 'project-${project.name}'
    scope: resourceGroup()
    params: {
      name: project.name
      devCenterId: devcenter.id
      environmentTypes: project.environmentTypes
      catalogs: project.catalogs
    }
  }
]

output projects array = [
  for (project, i) in settings.projects: {
    name: devCenterProjects[i].outputs.name
  }
]
