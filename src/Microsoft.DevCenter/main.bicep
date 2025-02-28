targetScope = 'subscription'

@description('Resource Group Name')
param rgName string

@description('Location')
param location string = 'eastus2'

var devCenterSettings = loadYamlContent('./settings/devcenter.yaml')

@description('Resource Group')
resource rg 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: rgName
  location: location
}

@description('Dev Center Module')
module devCenter 'devcenter.bicep' = {
  name: 'devcenter'
  scope: rg
  params: {
    settings: devCenterSettings
    identity: devCenterSettings.identity
  }
}

output rgName string = rg.name
output rgLocation string = rg.location
output name string = devCenter.outputs.name
output location string = devCenter.outputs.location
output catalogItemSyncEnableStatus string = devCenter.outputs.catalogItemSyncEnableStatus
output microsoftHostedNetworkEnableStatus string = devCenter.outputs.microsoftHostedNetworkEnableStatus
output installAzureMonitorAgentEnableStatus string = devCenter.outputs.installAzureMonitorAgentEnableStatus
