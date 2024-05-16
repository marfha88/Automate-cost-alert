targetScope = 'managementGroup'

param submanagement string
param rgName string

param saName string

param location string

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
  }
  dependsOn: [
    rg
  ]
}
