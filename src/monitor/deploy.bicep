var settings = loadJsonContent('./azure-inventory-dashboard.json')

module inventoryDashboard 'azure-dashboard.bicep' = {
  scope: resourceGroup()
  params: {
    location: resourceGroup().location
    settings: settings
  }
}
