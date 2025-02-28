@description('Name of the Catalog')
param name string

@description('Project Name')
param projectName string

@description('Type of the Catalog')
@allowed([
  'gitHub'
  'adoGit'
])
param type string

@description('URI of the Catalog')
param uri string

@description('Branch of the Catalog')
param branch string

@description('Path of the Catalog')
param path string

resource project 'Microsoft.DevCenter/projects@2024-10-01-preview' existing = {
  name: projectName
  scope: resourceGroup()
}

@description('Catalog Resource')
resource catalog 'Microsoft.DevCenter/projects/catalogs@2024-10-01-preview' = {
  name: name
  parent: project
  properties: type == 'gitHub'
    ? {
        gitHub: {
          uri: uri
          branch: branch
          path: path
        }
      }
    : {
        adoGit: {
          uri: uri
          branch: branch
          path: path
        }
      }
}

output name string = catalog.name
output type string = type
output uri string = (type == 'gitHub') ? catalog.properties.gitHub.uri : catalog.properties.adoGit.uri
output branch string = (type == 'gitHub') ? catalog.properties.gitHub.branch : catalog.properties.adoGit.branch
output path string = (type == 'gitHub') ? catalog.properties.gitHub.path : catalog.properties.adoGit.path
