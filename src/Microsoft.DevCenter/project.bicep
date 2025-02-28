@description('Project Name')
param name string

@description('Dev Center ID')
param devCenterId string

@description('Project Environment Types')
param environmentTypes ProjectEnvironmentType[]

type ProjectEnvironmentType = {
  name: string
  identity: Identity
  displayName: string
  deploymentTargetId: string
}

@description('Dev Center Identity')
type Identity = {
  type: IdentityType
}

type IdentityType = 'SystemAssigned' | 'UserAssigned' | 'None' | 'SystemAssigned, UserAssigned'

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
    displayName: environmentType.displayName
    deploymentTargetId: environmentType.deploymentTargetId
    identity: {
      type: environmentType.identity.type
    }
  }
]
