targetScope = 'resourceGroup'

param name string
param location string
param tags object
param containerName string

resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: tags
}

resource blob 'Microsoft.Storage/storageAccounts/blobServices@2023-04-01' = {
  name: 'default'
  parent: sa
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
  name: containerName
  parent: blob
}

@description('Name of the blob as it is stored in the blob container')
param filenames array

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = [for filename in filenames: {
  name: 'deploymentScript-${filename}'
  location: location
  kind: 'AzureCLI'
  properties: {
    azCliVersion: '2.26.1'
    timeout: 'PT5M'
    retentionInterval: 'PT1H'
    environmentVariables: [
      {
        name: 'AZURE_STORAGE_ACCOUNT'
        value: sa.name
      }
      {
        name: 'AZURE_STORAGE_KEY'
        secureValue: sa.listKeys().keys[0].value
      }

    ]
    scriptContent: 'echo "upload" > ${filename} && az storage blob upload -f ${filename} -c ${containerName} -n ${filename}'
  }
}]
