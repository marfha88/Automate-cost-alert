targetScope = 'managementGroup'

param subs array = [
  '1e5cbc27-c885-4f6c-b0a5-d208a6577309' // Martin Test sub1
  '9ac95d51-3163-4c77-9634-7bb68cd15df2' // Martin Test sub2
]

module costanomalyalert 'cost-anomaly-alert.bicep' = [for sub in subs: {
  name: '${sub}-costanomalyalert'
  scope: subscription(sub)
}]
