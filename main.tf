// import already created resource group created
data "azurerm_resource_group" "resourceGroup" {
  name = "test_xyz-Group-proxy-container"
}

// import already created key vaults to update container url values as secrets
data "azurerm_key_vault" "keyVault" {
  name                = "testapiskeyvault"
  resource_group_name = data.azurerm_resource_group.resourceGroup.name
}

module "logWorkspace" {
  source                    = "./modules/workspace"
  project                   = var.project
  env                       = var.env
  logAnalyticsWorkspaceName = var.logAnalyticsWorkspaceName
  resourceGroupName         = data.azurerm_resource_group.resourceGroup.name
  resourceGroupRegion       = data.azurerm_resource_group.resourceGroup.location
  logRetentionPeriod        = 30
}
module "appEnvironment" {
  source              = "./modules/appenvironment"
  project             = var.project
  env                 = var.env
  appEnvironmentName  = var.appEnvironmentName
  logWorkSpaceId      = module.logWorkspace.logWorkSpaceId
  resourceGroupName   = data.azurerm_resource_group.resourceGroup.name
  resourceGroupRegion = data.azurerm_resource_group.resourceGroup.location
}

module "axyzcontainerapp" {
   depends_on = [module.appEnvironment]
   for_each   = { for idx, app in var.axyzcontainerapps : idx => app }

   source              = "./modules/containerApps"
   project             = var.project
   env                 = var.env
   resourceGroupRegion = data.azurerm_resource_group.resourceGroup.location
   resourceGroupId     = data.azurerm_resource_group.resourceGroup.id
   appEnvironmentId    = module.appEnvironment.appEnvironmentId
   keyVaultRG          = data.azurerm_resource_group.resourceGroup.name
   keyVaultName        = each.value["keyVaultName"]
   containerAppName    = each.value["containerAppName"]
   dockerImage         = each.value["docker_image"]
   maxReplicas         = each.value["max_replicas"]
   minReplicas         = each.value["min_replicas"]
   envVariables        = each.value["env_variables"]
   secrets             = each.value["secrets"]
 }

resource "azurerm_key_vault_secret" "apisecret" {
   depends_on   = [module.axyzcontainerapp]
   name         = "awsaxyzurl"
   value        = module.XYZcontainerapp["axyz"].containerAppUrl
   key_vault_id = data.azurerm_key_vault.keyVault.id
 }

module "apiscontainerapp" {
  depends_on = [azurerm_key_vault_secret.apisecret]
  for_each = { for idx, app in var.apiscontainerapps : idx => app }

  source              = "./modules/containerApps"
  project             = var.project
  env                 = var.env
  resourceGroupRegion = data.azurerm_resource_group.resourceGroup.location
  resourceGroupId     = data.azurerm_resource_group.resourceGroup.id
  appEnvironmentId    = module.appEnvironment.appEnvironmentId
  keyVaultRG          = data.azurerm_resource_group.resourceGroup.name
  keyVaultName        = each.value["keyVaultName"]
  containerAppName    = each.value["containerAppName"]
  dockerImage         = each.value["docker_image"]
  maxReplicas         = each.value["max_replicas"]
  minReplicas         = each.value["min_replicas"]
  envVariables        = each.value["env_variables"]
  secrets             = each.value["secrets"]
}

 module "proxycontainerapp" {
   for_each = { for idx, app in var.proxycontainerapps : idx => app }

   source              = "./modules/containerApps"
   project             = var.project
   env                 = var.env
   resourceGroupRegion = data.azurerm_resource_group.resourceGroup.location
   resourceGroupId     = data.azurerm_resource_group.resourceGroup.id
   appEnvironmentId    = module.appEnvironment.appEnvironmentId
   keyVaultRG          = data.azurerm_resource_group.resourceGroup.name
   keyVaultName        = each.value["keyVaultName"]
   containerAppName    = each.value["containerAppName"]
   dockerImage         = each.value["docker_image"]
   maxReplicas         = each.value["max_replicas"]
   minReplicas         = each.value["min_replicas"]
 }


// module to create multiple storage account

 module "storageaccount" {
   source              = "./modules/storageaccount"
   project             = var.project
   env                 = var.env
   resourceGroupRegion = "East US"
   resourceGroupName   = "xyz-RG"
   for_each = { for idx, name in var.storageAccountNames : idx => name }
   storageAccountName = each.value
 }

 module "frontdoor" {
   source            = "./modules/frontdoor"
   fdprofileName     = "abcfrontdoor"
   resourceGroupName = module.resourceGroup.resourceGroupName
   appContainerUrl   = local.containerapp_urls["proxy"]
   project           = var.project
   env               = var.env
   customDomainName  = "abc-xyz-app"
   domainHostName    = "abc.xyz.app"
   recordName        = "abc"
   dnsZoneRG         = "xyz-rg"
   dnsZoneName       = "xyz.app"
 }



