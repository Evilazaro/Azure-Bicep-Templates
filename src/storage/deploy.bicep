module storageAccount './storage-account.bicep' = {
  scope: resourceGroup()
  name: 'deploy-storage-account'
  params: {
    name: 'azurebiceptempstorage'
  }
}

module blobContainer './storage-blob-container.bicep' = {
  scope: resourceGroup()
  name: 'deploy-storage-blob-container'
  params: {
    name: 'mycontainer'
    storageAccountName: storageAccount.outputs.AZURE_STORAGE_ACCOUNT_NAME
  }
}

@description('The name of the storage account.')
output AZURE_STORAGE_ACCOUNT_NAME string = storageAccount.outputs.AZURE_STORAGE_ACCOUNT_NAME
