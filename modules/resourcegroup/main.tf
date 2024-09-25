resource "azurerm_resource_group" "azureRG" {
  location = var.azRegion
  name     = "${var.rgName}-Group-${var.project}"
  tags = {
    project     = var.project
    Environment = var.env
  }
}
