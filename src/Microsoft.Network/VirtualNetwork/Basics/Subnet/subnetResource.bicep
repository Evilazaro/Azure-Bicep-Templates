@description('Virtual Network Name')
param virtualNetworkName string

@description('Subnet Name')
param name string

@description('Subnet Address Prefix')
param addressPrefix array

@description('Private Subnet')
param privateSubnet string

@description('Private Endpoint network policies')
param privateEndpointNetworkPolicies string

@description('Virtual Network Resource')
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: virtualNetworkName
}

@description('Subnet Resource')
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  name: '${name}-${uniqueString(virtualNetwork.id, name)}-subnet}'
  parent: virtualNetwork
  properties: {
    addressPrefixes: addressPrefix
    privateLinkServiceNetworkPolicies: privateSubnet
    privateEndpointNetworkPolicies: privateEndpointNetworkPolicies
  }
}
