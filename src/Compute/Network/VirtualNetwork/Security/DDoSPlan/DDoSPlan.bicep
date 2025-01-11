@description('DDoS Protection Plan Name')
param name string

@description('Location')
param location string = resourceGroup().location

@description('DDoS Protection Plan')
resource ddosProtectionPlan 'Microsoft.Network/ddosProtectionPlans@2024-05-01' =  {
  name: 'ddosPlan-${uniqueString(resourceGroup().id, '${name}')}'
  location: location
}
