@description('The location where the dashboard will be deployed.')
param location string

@description('The settings for the dashboard.')
param settings object

@description('The dashboard resource.')
resource dashboard 'Microsoft.Portal/dashboards@2025-04-01-preview' = {
  name: settings.name
  location: location
  properties: settings.properties
  tags: settings.tags
}

@description('The Dashboard name')
output dashboardName string = dashboard.name

@description('The Dashboard location')
output dashboardLocation string = dashboard.location
