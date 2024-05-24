targetScope = 'managementGroup'

param submanagement string
param rgName string

param saName string
param aaName string
param location string
param containerName string

param tags object

module rg 'modules/rg.bicep' = {
  scope: subscription(submanagement)
  name: rgName
  params: {
    location: location
    rgName: rgName
    tags: tags
  }
}

module sa 'modules/sa.bicep' = {
  scope: resourceGroup(submanagement, rgName)
  name: saName
  params: {
    location: location
    name: saName
    tags: tags
    containerName: containerName
    filenames: [
      '../../extra-config/cost-anomaly-alert.bicep'
      '../../extra-config/deploycost.ps1'
      '../../extra-config/main.bicep'
    ]
  }
  dependsOn: [
    rg
  ]
}

module aa 'modules/aa.bicep' = {
  scope: resourceGroup(submanagement, rgName)
  name: aaName
  params: {
    location: location
    name: saName
    tags: tags
  }
  dependsOn: [
    sa
  ]
}

module rbac 'modules/rbac.bicep' = {
  scope: resourceGroup(submanagement, rgName)
  name: 'rbac'
  params: {
    automation_accountspid: aa.outputs.msiId
    rg: rgName
  }
}
