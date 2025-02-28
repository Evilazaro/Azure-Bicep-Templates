@description('Name of the virtual network.')
param name string

@description('Location of the virtual network.')
param location string = resourceGroup().location

@description('Address space of the virtual network.')
param addressPrefixes array = [
  '10.0.0.0/16'
]

@description('Tags of the virtual network.')
param tags object = {}

@description('Virtual Network Resource')
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
  }
}

output name string = virtualNetwork.name
output addressPrefixes array = virtualNetwork.properties.addressSpace.addressPrefixes
