@description('Virtual Network Name')
param virtualNetworkName string

@description('Subnet Name')
param name string

@description('Subnet Address Prefix')
param addressPrefix string

@description('Virtual Network Resource')
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: virtualNetworkName
}

@description('Subnet Resource')
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  name: '${name}-${uniqueString(virtualNetwork.id, name)}-subnet}'
  parent: virtualNetwork
  properties: {
    addressPrefix: addressPrefix
  }
}
