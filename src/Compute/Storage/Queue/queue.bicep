@description('Storage Account Queue name')
param name string

@description('Existing Storage Account name')
@maxLength(24)
@minLength(3)
param storageAccountName string

@description('Existing Storage Account')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
}

@description('Deloy Storage Account Queue to Azure')
resource storageQueueService 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  name: 'default'
  parent: storageAccount
}

resource storageQueue 'Microsoft.Storage/storageAccounts/queueServices/queues@2023-05-01' = {
  name: name
  parent: storageQueueService
}

