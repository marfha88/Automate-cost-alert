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
param filename1 string


resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'deployscript-upload-blob'
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
      {
        name: 'CONTENT'
        value: loadTextContent('../../extra-config/deploycost.ps1')
      }
    ]
    scriptContent: 'echo "$CONTENT" > ${filename1} && az storage blob upload -f ${filename1} -c ${containerName} -n ${filename1}'
  }
}

@description('Name of the blob as it is stored in the blob container')
param filename2 string


resource deploymentScript2 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'deployscript-upload-blob2'
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
      {
        name: 'CONTENT'
        value: loadTextContent('../../extra-config/cost-anomaly-alert.bicep')
      }
    ]
    scriptContent: 'echo "$CONTENT" > ${filename2} && az storage blob upload -f ${filename2} -c ${containerName} -n ${filename2}'
  }
}

@description('Name of the blob as it is stored in the blob container')
param filename3 string


resource deploymentScript3 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'deployscript-upload-blob3'
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
      {
        name: 'CONTENT'
        value: loadTextContent('../../extra-config/main.bicep')
      }
    ]
    scriptContent: 'echo "$CONTENT" > ${filename3} && az storage blob upload -f ${filename3} -c ${containerName} -n ${filename3}'
  }
}
