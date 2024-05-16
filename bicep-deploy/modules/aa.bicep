param name string
param location string
param tags object
//param workspaceId string
// param schedules object

//@description('Adds start time to schedules')
//param utcShortValue string = utcNow('d')

//var start01am = dateTimeAdd(utcShortValue, 'PT24H') // 01:00 AM

/*
var schedule = [
    {
      name: 'daily 0100'    
        description: 'daily 0100'
        frequency: 'day'
        interval: 1
        startTime: start01am
        timeZone: 'Europe/Oslo'
    }  
]
*/

resource automation_account 'Microsoft.Automation/automationAccounts@2022-08-08' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    disableLocalAuth: true
    publicNetworkAccess: true
    sku: {
      name: 'Basic'
    }
    encryption: {
      keySource: 'Microsoft.Automation'
    }

  }
}

output msiId string = automation_account.identity.principalId

resource runbook 'Microsoft.Automation/automationAccounts/runbooks@2023-11-01' = {
  name: '${automation_account.id}/deploy-costalert'
  properties: {
    runbookType: 'PowerShell72'
  }
}
