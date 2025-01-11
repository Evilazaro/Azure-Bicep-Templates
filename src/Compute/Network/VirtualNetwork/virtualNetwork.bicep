@description('Virtual Network Name')
param name string

@description('Virtual Network Location')
param location string = resourceGroup().location

@description('Virtual Network Address Prefixes')
param addressPrefixes array

@description('Tags')
param tags object

@description('Virtual Network Resource')
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-03-01' = {
  name: '${uniqueString(resourceGroup().id, name)}-vNet'
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
  }
}
