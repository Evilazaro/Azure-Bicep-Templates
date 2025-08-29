module storageAccount './storage-account.bicep' = {
  scope: resourceGroup()
  name: 'deploy-storage-account'
  params: {
    name: 'azurebiceptempstorage'
    location: resourceGroup().location
  }
}

module blobContainer './storage-blob-container.bicep' = {
  scope: resourceGroup()
  name: 'deploy-storage-blob-container'
  params: {
    name: 'mycontainer'
    storageAccountName: storageAccount.outputs.storageAccountName
  }
}

@description('The name of the storage account.')
output AZURE_STORAGE_ACCOUNT_NAME string = storageAccount.outputs.storageAccountName
