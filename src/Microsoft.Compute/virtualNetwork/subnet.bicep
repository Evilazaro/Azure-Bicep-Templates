@description('Name of the subnet.')
param name string

@description('Name of the virtual network.')
param virtualNetworkName string

@description('Address prefix of the subnet.')
param addressPrefix string

@description('Virtual Network Resource')
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: virtualNetworkName
  scope: resourceGroup()
}

@description('Subnets Resource')
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: name
  parent: virtualNetwork
  properties: {
    addressPrefix: addressPrefix
  }
}

output id string = subnet.id
output name string = subnet.name
output virtualNetworkName string = virtualNetwork.name
output addressPrefix string = subnet.properties.addressPrefix
