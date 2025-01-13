@description('App Service Name')
param name string = 'appServiceEY'

@description('App Service Plan Name')
param appServicePlanName string = 'appServicePlanEY'

@description('App Service Location')
param location string = resourceGroup().location

@description('App Service Kind')
@allowed([
  'app'
  'app,linux'
  'app,linux,container'
  'hyperV'
  'app,container,windows'
  'app,linux,kubernetes'
  'app,linux,container,kubernetes'
  'functionapp'
  'functionapp,linux'
  'functionapp,linux,container,kubernetes'
  'functionapp,linux,kubernetes'
])
param kind string = 'app,linux'

@description('App Service Current Stack')
@allowed([
  'dotnetcore'
  'java'
  'node'
  'php'
])
param currentStack string = 'dotnetcore'

@description('netFrameworkVersion')
@allowed([
  '7.0'
  '8.0'
  '9.0'
  ''
])
param dotnetcoreVersion string = '9.0'

@description('App Service Plan SKU')
param sku object = {
  name: 'P1V3'
  tier: 'PremiumV3'
  capacity: 1
}

@description('App Settings')
param appSettings array = []

@description('Tags')
param tags object = {}

@description('App Service Plan Resource')
module appServicePlan 'AppServicePlan/appServicePlan.bicep' = {
  name: appServicePlanName
  params: {
    name: appServicePlanName
    kind: kind
    sku: sku
    tags: tags
  }
}

@description('LinuxFxVersion')
var linuxFxVersion = (contains(kind, 'linux')) ? '${toUpper(currentStack)}|${dotnetcoreVersion}' : null

@description('App Service Resource')
resource appService 'Microsoft.Web/sites@2024-04-01' = {
  name: '${name}-${uniqueString(resourceGroup().id,name)}-appsvc'
  location: location
  kind: kind
  properties: {
    serverFarmId: appServicePlan.outputs.appServicePlanId
    enabled: true
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      alwaysOn: true
      minimumElasticInstanceCount: 1
      http20Enabled: true
      appSettings: appSettings
    }
  }
}

@description('App Servicea Deployment Slots')
resource deploymentSlots 'Microsoft.Web/sites/slots@2024-04-01' = [
  for slot in ['dev', 'staging', 'UAT']: {
    name: slot
    parent: appService
    location: location
    properties: {
      serverFarmId: appServicePlan.outputs.appServicePlanId
      cloningInfo: {
        sourceWebAppId: appService.id
      }
    }
  }
]
