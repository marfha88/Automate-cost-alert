using './main.bicep'

param submanagement = '1e5cbc27-c885-4f6c-b0a5-d208a6577309'
param location = 'westeurope'
param rgName = 'rg-bicep-test'
param tags = {
  deployment_tool: 'Bicep'
  environment: 'shared'
  owner: 'test'
  risk: 'low'
  creationdate: '2023-05-016'
  repo: 'https://github.com/marfha88/Automate-cost-alert'
  createdby: 'marfha88@icloud.com'
}

param saName = 'saautocostalert01'
param aaName = 'aaautocostalert01'
