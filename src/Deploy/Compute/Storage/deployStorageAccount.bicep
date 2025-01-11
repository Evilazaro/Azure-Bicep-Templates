@description('Workload/Solution name')
@minLength(3)
@maxLength(22)
param workloadName string

@description('Environment Type')
@allowed([
  'nonprod'
  'prod'
  'dev'
])
param environmentType string = 'dev'

@description('SKU for the storage account')
var sku = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

@description('Kind of storage account')
var kind = ('StorageV2')

@description('Acces Tier')
var accessTier = 'Hot'

@description('Tags for the storage account')
var tags = {
  workload: workloadName
  displayName: 'Storage Account'
  purpose: 'General storage'
  environment: 'Production'
  costCenter: '12345'
  createdBy: 'Bicep'
  createdOn: '2021-09-01'
  lastModifiedBy: 'Bicep'
  lastModifiedOn: '2021-09-01'
  version: '1.0'
  department: 'IT'
  solution: 'Platform Engineering'
  project: 'Platform Engineering'
  owner: 'Platform Engineering'
  managedBy: 'Platform Engineering'
  automation: 'Yes'
  retention: '7 years'
}

module storageAccount '../../../Compute/Storage/storageAccount.bicep' = {
  name: workloadName
  scope: resourceGroup()
  params: {
    name: workloadName
    sku: sku
    kind: kind
    accessTier: accessTier
    tags: tags
  }
}

@description('Storage Account Resource Id')
output storageAccountId string = storageAccount.outputs.storageAccountId

@description('Storage Account Name')
output storageAccountName string = storageAccount.outputs.storageAccountName

@description('Storage Account URL')
output storageAccountUrl string = storageAccount.outputs.storageAccountUrl

@description('Storage Account SKU')
output storageAccountSku string = storageAccount.outputs.storageAccountSku

@description('Storage Account Kind')
output storageAccountKind string = storageAccount.outputs.storageAccountKind

@description('Storage Account Tags')
output storageAccountTags object = storageAccount.outputs.storageAccountTags
