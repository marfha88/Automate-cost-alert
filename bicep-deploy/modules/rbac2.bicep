targetScope = 'subscription'

param automation_accountspid string
param roleid string = 'b24988ac-6180-42a0-ab88-20f7382dd24c'
//param subcore string 
param sub string


@description('This is the built-in Contributor role. b24988ac-6180-42a0-ab88-20f7382dd24c) See https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#virtual-machine-contributor')
resource roledefid 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' existing = {
  scope: subscription(sub)
  name: roleid
}

@description('Role assignment for Contributor on subscription')
resource roleAssignment1 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(sub, automation_accountspid, roledefid.id)
  properties: {
    roleDefinitionId: roledefid.id
    principalId: automation_accountspid
    principalType: 'ServicePrincipal'
  }
}
