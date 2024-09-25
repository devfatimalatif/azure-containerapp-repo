resource "azurerm_container_app_environment" "app_environment" {
  name                       = "${var.appEnvironmentName}-${var.project}-${var.env}"
  location                   = var.resourceGroupRegion
  resource_group_name = var.resourceGroupName
  log_analytics_workspace_id = var.logWorkSpaceId
  tags = {
    project     = var.project
    Environment = var.env
  }
}