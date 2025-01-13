@description('Storage account name')
@maxLength(24)
@minLength(3)
param name string

@description('Storage Account Location')
param location string = resourceGroup().location

@description('Storage account Sku')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
])
param sku string

@description('Storage account kind')
@allowed([
  'StorageV2'
  'BlobStorage'
])
param kind string

@description('Storage Account access tier')
@allowed([
  'Hot'
  'Cool'
])
param accessTier string

@description('Storage account tags')
param tags object

@description('Deploy Storage account resource to Azure')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '${uniqueString(resourceGroup().id, name)}sa'
  location: location
  sku: {
    name: sku
  }
  kind: kind
  properties: {
    accessTier: accessTier
  }
  tags: tags
}
