@description('Project Name')
param name string

@description('Dev Center ID')
param devCenterId string

@description('Project Environment Types')
param environmentTypes ProjectEnvironmentType[]

@description('Project Catalogs')
param catalogs Catalog[]

type ProjectEnvironmentType = {
  name: string
  identity: Identity
  deploymentTargetId: string
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

@description('Project Resource')
resource project 'Microsoft.DevCenter/projects@2024-10-01-preview' = {
  name: name
  location: resourceGroup().location
  properties: {
    devCenterId: devCenterId
  }
}

output name string = project.name
output location string = project.location

@description('Project Environment Types')
module envvironmentType 'projectEnvironmentType.bicep' = [
  for environmentType in environmentTypes: {
    name: environmentType.name
    scope: resourceGroup()
    params: {
      name: environmentType.name
      projectName: project.name
      identityType: environmentType.identity.type
      deploymentTargetId: environmentType.deploymentTargetId
    }
  }
]

output environmentType array = [
  for environmentType in environmentTypes: {
    name: environmentType.name
    deploymentTargetId: environmentType.deploymentTargetId
    identity: environmentType.identity
  }
]

@description('Project Catalogs')
module catalog 'projectCatalog.bicep' = [
  for catalog in catalogs: {
    name: catalog.name
    scope: resourceGroup()
    params: {
      projectName: project.name
      name: catalog.name
      type: catalog.type
      uri: catalog.uri
      branch: catalog.branch
      path: catalog.path
    }
  }
]

output catalogs array = [
  for catalog in catalogs: {
    name: catalog.name
    type: catalog.type
    uri: catalog.uri
    branch: catalog.branch
    path: catalog.path
  }
]
