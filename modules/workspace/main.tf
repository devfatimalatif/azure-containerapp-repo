resource "azurerm_log_analytics_workspace" "analytics_workspace" {
  name                = "${var.logAnalyticsWorkspaceName}-${var.project}-${var.env}"
  location            = var.resourceGroupRegion
  resource_group_name = var.resourceGroupName
  retention_in_days   = var.logRetentionPeriod
  tags = {
    project     = var.project
    Environment = var.env
  }
}