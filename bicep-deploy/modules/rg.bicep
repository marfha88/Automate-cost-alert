targetScope = 'subscription'

param rgName string

param location string

param tags object

// Create a resource group
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: rgName
  location: location
  tags: tags
}
