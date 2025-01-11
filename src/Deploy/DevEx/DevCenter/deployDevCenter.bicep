@description('Workload Name')
param workloadName string

@description('Catalog Item Sync Enable Status')
var catalogItemSyncEnableStatus = 'Enabled'

@description('Microsoft Hosted Network Enable Status')
var microsoftHostedNetworkEnableStatus = 'Enabled'

@description('Install Azure Monitor Agent Enable Status')
var installAzureMonitorAgentEnableStatus = 'Enabled'

@description('Tags')
var tags = {
  workloadName: workloadName
  environment: 'dev'
  workloadType: 'devCenter'
  costCenter: 'devCenter'
  owner: 'devCenter'
  createdBy: 'devCenter'
  createdOn: 'devCenter'
  updatedBy: 'devCenter'
  updatedOn: 'devCenter'
  deleteBy: 'devCenter'
  deleteOn: 'devCenter'
  retention: 'devCenter'
}

@description('Deploy Dev Center resource to Azure')
module deployDevCenter '../../../DevEx/DevCenter/devCenter.bicep' = {
  name: 'DevCenter'
  scope: resourceGroup()
  params: {
    name: workloadName
    tags: tags
    location: resourceGroup().location
    catalogItemSyncEnableStatus: catalogItemSyncEnableStatus
    microsoftHostedNetworkEnableStatus: microsoftHostedNetworkEnableStatus
    installAzureMonitorAgentEnableStatus: installAzureMonitorAgentEnableStatus
  }
}

@description('Output Dev Center resource id')
output devCenterId string = deployDevCenter.outputs.devCenterId

@description('Output Dev Center name')
output devCenterName string = deployDevCenter.outputs.devCenterName

@description('Output Dev Center Catalog Item Sync Enable Status')
output catalogItemSyncEnableStatus string = deployDevCenter.outputs.devCenterCatalogItemSyncEnableStatus

@description('Output Dev Center Microsoft Hosted Network Enable Status')
output microsoftHostedNetworkEnableStatus string = deployDevCenter.outputs.devCenterMicrosoftHostedNetworkEnableStatus

@description('Output Dev Center Install Azure Monitor Agent Enable Status')
output installAzureMonitorAgentEnableStatus string = deployDevCenter.outputs.devCenterInstallAzureMonitorAgentEnableStatus

@description('Output Dev Center location')
output devCenterLocation string = deployDevCenter.outputs.devCenterLocation

@description('Attach Dev Center to Network Connection')
module networkConnectionAttachment '../../../DevEx/DevCenter/NetworkConnection/networkConnectionAttachment.bicep' = {
  name: 'DevCenter-NetworkConnection-Attachment'
  params: {
    devCenterName: deployDevCenter.name
    name: devCenterName
    networkConnectionResourceGroupName: 
  }
}
