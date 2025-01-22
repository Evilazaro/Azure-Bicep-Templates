@description('The name of the Managed Cluster resource.')
param name string = 'aks101cluster'

@description('The location of the Managed Cluster resource.')
param location string = resourceGroup().location

@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string = name

@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
@minValue(0)
@maxValue(1023)
param osDiskSizeGB int = 128

@description('The number of nodes for the cluster.')
@minValue(1)
@maxValue(50)
param agentCount int = 3

@description('The size of the Virtual Machine.')
param agentVMSize string = 'standard_d2s_v3'

@description('Kubernetes Version')
@allowed([
  '1.30.7'
])
param kubernetesVersion string = '1.30.7'

@description('OS Type')
@allowed([
  'Linux'
  'Windows'
])
param osType string = 'Linux'

@description('OS SKU')
@allowed([
  'Ubuntu'
  'Windows'
])
param osSKU string = 'Ubuntu'

@description('The agent pool profiles for the Managed Cluster.')
param agentPoolProfiles array = [
  {
    mode: 'System'
    name: 'nodepool1'
    count: agentCount
    vmSize: agentVMSize
    osDiskType: 'Managed'
    osDiskSizeGB: osDiskSizeGB
    kubeletDiskType: 'OS'
    osType: osType
    osSKU: osSKU
    orchestratorVersion: kubernetesVersion
    enableAutoScaling: true
    minCount: agentCount
    maxCount: 10
  }
  {
    mode: 'User'
    name: 'appnodepool'
    count: agentCount
    vmSize: agentVMSize
    osDiskType: 'Managed'
    osDiskSizeGB: osDiskSizeGB
    kubeletDiskType: 'OS'
    osType: osType
    osSKU: osSKU
    orchestratorVersion: kubernetesVersion
    enableAutoScaling: true
    minCount: agentCount
    maxCount: 10
  }
  {
    mode: 'User'
    name: 'dbnodepool'
    count: agentCount
    vmSize: agentVMSize
    osDiskType: 'Managed'
    osDiskSizeGB: osDiskSizeGB
    kubeletDiskType: 'OS'
    osType: osType
    osSKU: osSKU
    orchestratorVersion: kubernetesVersion
    enableAutoScaling: true
    minCount: agentCount
    maxCount: 10
  }
]

@description('Enable Virtual Node Pools')
param enableVirtualNode bool = false

@description('The AKS Managed Cluster resource.')
resource aks 'Microsoft.ContainerService/managedClusters@2024-09-01' = {
  name: name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    azureMonitorProfile: {
      metrics:{
        enabled: true
      }
    }
    dnsPrefix: dnsPrefix
    agentPoolProfiles: agentPoolProfiles
    addonProfiles: {
      virtualNode: {
        enabled: enableVirtualNode
      }
    }
  }
}
