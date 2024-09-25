resource "azurerm_container_registry_webhook" "example" {
  name                = "server-webhook"
  location = "East US"
  resource_group_name = "xyz-RG"
  registry_name       = "xyzproxyserver"  # Replace with your ACR name
  service_uri         = "https://xyz-container-test.greensea-f0e654fb.westus.azurecontainerapps.io"
  custom_headers      = {
    "Content-Type" = "application/json"
  }
  status              = "enabled"
  scope               = "xyz.azurecr.io/xyz/xyz-server:latest"  # Replace with your image name
  actions             = ["push"]
}