using './main.bicep'

param subSand01 = '3079be22-73e7-41f2-a5e1-62a312d27daf'
param location = 'westeurope'
param rgName = 'rg-bicep-test'
param tags = {
  deployment_tool: 'Bicep'
  environment: 'dev'
  owner: 'test'
  risk: 'low'
  creationdate: '2023-05-03'
  repo: 'https://github.com/brreg/azure-infrastructure'
  createdby: 'martin.fahlbeck@crayon.com'
}

param saName = 'rlabsa01'
