
@description('Workload name')
param workloadName string

@description('Resource Group Name')
param virtualNetworkResourceGroupName string = resourceGroup().name

@description('Subnet Name')
param subnetName string

@description('Deploy Network Connection')
module deployNetworkConnection '../../../../DevEx/DevCenter/NetworkConnection/networkConnection.bicep' = {
  name: 'networkConnection'
  scope: resourceGroup(virtualNetworkResourceGroupName)
  params: {
    virtualNetworkName: '${uniqueString(resourceGroup().id, workloadName)}-vnet'
    subnetName: subnetName
    virtualNetworkResourceGroupName: virtualNetworkResourceGroupName
    domainJoinType: 'AzureADJoin'
  }
}
