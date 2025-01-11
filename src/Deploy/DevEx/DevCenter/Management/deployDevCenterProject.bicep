@description('Dev Center Name')
param devCenterName string

@description('Projects')
var projects = [
  {
    name: 'Project1'
    tags: {
      tag1: 'value1'
    }
  }
  {
    name: 'Project2'
    tags: {
      tag2: 'value2'
    }
  }
]

module deployDevCenterProject '../../../../DevEx/DevCenter/Management/devCenterProject.bicep' = [
  for project in projects: {
    name: 'Project-${project}'
    params: {
      devCenterName: devCenterName
      name: project.name
      tags: project.tags
    }
  }
]

@description('Dev Center Project Resource IDs')
output devCenterProjectIds array = [for (project,i) in projects: deployDevCenterProject[i].outputs.devCenterProjectId]

@description('Dev Center Project Resource Names')
output devCenterProjectNames array = [for (project,i) in projects: deployDevCenterProject[i].outputs.devCenterProjectName]
