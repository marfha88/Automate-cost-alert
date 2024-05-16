targetScope = 'managementGroup'

param subSand01 string
param rgName string

param saName string

param location string

param tags object

module rg 'modules/rg.bicep' = {
  scope: subscription(subSand01)
  name: rgName
  params: {
    location: location
    rgName: rgName
    tags: tags
  }
}

module sa 'modules/sa.bicep' = {
  scope: resourceGroup(subSand01, rgName)
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
