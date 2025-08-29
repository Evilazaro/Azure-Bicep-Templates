@description('The name of the storage account.')
param storageAccountName string

@description('The name of the blob container.')
param name string

@description('The Storage Account resource.')
resource storageAccount 'Microsoft.Storage/storageAccounts@2025-01-01' existing = {
  name: storageAccountName
}

@description('The Blob Service resource.')
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2025-01-01' existing = {
  parent: storageAccount
  name: 'default'
}

@description('The Blob Container resource.')
resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-01-01' = {
  name: name
  parent: blobService
}

@description('The Blob Container name')
output blobContainerName string = blobContainer.name
