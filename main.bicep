param automationAccountName string = 'automation-account1'
param location string = resourceGroup().location
param workspaceId string = string('')


param tags object = {
  my: 'my'
}

resource automationAccountResource 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: automationAccountName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    disableLocalAuth: false
    sku: {
      name: 'Basic'
    }
    encryption: {
      keySource: 'Microsoft.Automation'
      identity: {}
    }
  }
}

resource automationAccountName_Microsoft_Insights_service 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'diagnosticSettings'
  properties: {
    workspaceId: workspaceId
    logs: [
      {
        category: 'JobLogs'
        enabled: true
        retentionPolicy: {
          days: 0
          enabled: false
        }
      }
      {
        category: 'JobStreams'
        enabled: true
        retentionPolicy: {
          days: 0
          enabled: false
        }
      }
      {
        category: 'DSCNodeStatus'
        enabled: true
        retentionPolicy: {
          days: 0
          enabled: false
        }
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          days: 0
          enabled: false
        }
      }
    ]
  }
  dependsOn: [
    automationAccountResource
  ]
}
