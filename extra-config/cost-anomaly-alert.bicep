targetScope = 'subscription'

@description('The anomaly alert start data must be in UTC format and can not be in the past. Default value is one minute in the future.')
param anomalyAlertStartDate string = dateTimeAdd(utcNow(), 'PT1M')

var anomalyAlertName = replace(replace('anomaly-alert-${subscription().displayName}','.','-'),' ','-')
var anomalyAlertSubject = length('Cost anomaly detected in the ${subscription().displayName} subscription') > 70 ? substring('Cost anomaly detected in the ${subscription().displayName} subscription',0,70) : 'Cost anomaly detected in the ${subscription().displayName} subscription'
var anomalyAlertEndDate = dateTimeAdd(anomalyAlertStartDate, 'P1Y')
var contactEmail = 'cdgm-it-m365health@nmbu.no'

resource anomolityAlertView 'Microsoft.CostManagement/views@2022-10-01' existing = {
  name: 'ms:DailyAnomalyByResourceGroup'
}

resource anomolityAlert 'Microsoft.CostManagement/scheduledActions@2022-10-01' = {
  name: anomalyAlertName
  kind: 'InsightAlert'
  properties: {
    displayName: 'Daily anomaly by resource group'
    scope: subscription().id
    notification: {
      subject: anomalyAlertSubject
      to: array(contactEmail)
    }
    schedule: {
      endDate: anomalyAlertEndDate
      frequency: 'Daily'
      hourOfDay: 12
      startDate: anomalyAlertStartDate
    }
    status: 'Enabled'
    viewId: anomolityAlertView.id
    notificationEmail: contactEmail
  }
}


