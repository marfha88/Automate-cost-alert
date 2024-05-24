targetScope = 'resourceGroup'

param automation_accountspid string
param roleid string = 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
//param subcore string 
param rg string


@description('This is the built-in Storage Blob Data Contributor role. (ba92f5b4-2d11-453d-a403-e96b0029c9fe) See https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#virtual-machine-contributor')
resource roledefid 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' existing = {
  scope: resourceGroup(rg)
  name: roleid
}

@description('Role assignment for Storage Blob Data Contributor on Resource Group')
resource roleAssignment1 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(rg, automation_accountspid, roledefid.id)
  properties: {
    roleDefinitionId: roledefid.id
    principalId: automation_accountspid
    principalType: 'ServicePrincipal'
  }
}
