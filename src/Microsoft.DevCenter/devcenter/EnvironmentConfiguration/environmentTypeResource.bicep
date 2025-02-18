@description('Dev Center Name')
param devCenterName string

@description('Environment Type Name')
param name string

@description('Tags')
param tags object

resource devCenter 'Microsoft.DevCenter/devcenters@2024-10-01-preview' existing = {
  name: devCenterName
  scope: resourceGroup()
}

@description('Environment Type Resource')
resource environmentType 'Microsoft.DevCenter/devcenters/environmentTypes@2024-10-01-preview' = {
  name: name
  parent: devCenter
  tags: tags
}
