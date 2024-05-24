targetScope = 'managementGroup'

param subs array = [
  '1e5cbc27-c885-4f6c-b0a5-d208a6577309' // Martin Test sub1
]

module costanomalyalert 'cost-anomaly-alert.bicep' = [for sub in subs: {
  name: '${sub}-costanomalyalert'
  scope: subscription(sub)
}]
