@description('Name of the environment type.')
param name string

@description('Dev Center Name')
param devCenterName string

@description('Dev Center Resource')
resource devcenter 'Microsoft.DevCenter/devcenters@2024-10-01-preview' existing = {
  name: devCenterName
  scope: resourceGroup()
}

@description('Environment Type Resource')
resource environmentType 'Microsoft.DevCenter/devcenters/environmentTypes@2024-10-01-preview' = {
  name: name
  parent: devcenter
  properties: {
    displayName: name
  }
}

output name string = environmentType.name
output displayName string = environmentType.properties.displayName
