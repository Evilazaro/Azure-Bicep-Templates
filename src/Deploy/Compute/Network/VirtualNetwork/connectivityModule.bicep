@description('Solution/Workload Name')
param workloadName string = 'myWorkloadName'

@description('Environment Type')
@allowed([
  'nonprod'
  'prod'
  'dev'
])
param environmentType string = 'dev'

@description('Virtual Network Address Prefixes')
var addressPrefixes = [
  '10.0.0.0/16'
]

@description('Subnets')
var subnets = [
  {
    name: 'default'
  }
  {
    name: 'myApp'
  }
  {
    name: 'myAppDb'
  }
  {
    name: 'myAppAKS'
  }
]

@description('Tags')
var tags = {
  workloadName: workloadName
  environment: 'dev'
  project: 'Platform-Engineering'
  costCenter: '12345'
  createdBy: 'John Doe'
  purpose: 'Virtual Network for my solution'
  department: 'IT'
  businessUnit: 'Platform Engineering'
  application: 'Platform'
  owner: 'John Doe'
  team: 'Platform Engineering'
  stack: 'Azure'
  location: resourceGroup().location
}

@description('Deploy DDoS Protection Plan Resource')
module ddosProtectionPlan '../../../../Compute/Network/DDoSPlan/DDoSPlan.bicep' = if (environmentType == 'prod') {
  name: 'DDoSProtectionPlan'
  scope: resourceGroup()
  params: {
    name: workloadName
  }
}


@description('Deploy Virtual Network Resource')
module deployVirtualNetwork '../../../../Compute/Network/VirtualNetwork/virtualNetwork.bicep' = {
  name: 'VirtualNetwork'
  scope: resourceGroup()
  params: {
    name: workloadName
    location: resourceGroup().location
    tags: tags
    addressPrefixes: addressPrefixes
    subnets: subnets
    enableDdosProtection: environmentType == 'prod'
    ddosProtectionPlanId: (environmentType == 'prod') ? ddosProtectionPlan.outputs.ddosProtectionPlanId : ''
  }
}

