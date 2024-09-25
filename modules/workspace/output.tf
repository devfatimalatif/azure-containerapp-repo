output "logWorkSpaceId" {
  description = "Log Analytics Workspace ID"
  value       = azurerm_log_analytics_workspace.analytics_workspace.id
}