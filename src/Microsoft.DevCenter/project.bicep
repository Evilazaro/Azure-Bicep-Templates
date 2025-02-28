@description('Project Name')
param name string

@description('Dev Center Name')
param devCenterId string

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
