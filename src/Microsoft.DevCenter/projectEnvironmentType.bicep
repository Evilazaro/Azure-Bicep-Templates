@description('Project Environment Name')
param name string

@description('Project Name')
param projectName string

@description('Identity Type')
@allowed(['SystemAssigned', 'UserAssigned', 'None', 'SystemAssigned, UserAssigned'])
param identityType string

@description('Deployment Target ID')
param deploymentTargetId string

resource project 'Microsoft.DevCenter/projects@2024-10-01-preview' existing = {
  name: projectName
  scope: resourceGroup()
}

@description('Project Environment Types')
resource envvironmentType 'Microsoft.DevCenter/projects/environmentTypes@2024-10-01-preview' = {
  name: name
  parent: project
  identity: {
    type: identityType
  }
  properties: {
    deploymentTargetId: (!empty(deploymentTargetId) ? deploymentTargetId : subscription().id)
    status: 'Enabled'
  }
}

output name string = envvironmentType.name
output deploymentTargetId string = envvironmentType.properties.deploymentTargetId
output identity object = envvironmentType.identity
