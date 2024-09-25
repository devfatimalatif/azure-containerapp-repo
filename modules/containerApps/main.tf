data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "keyVault" {
  name                = var.keyVaultName
  resource_group_name = var.keyVaultRG
}
data "azurerm_key_vault_secret" "dockerpassword" {
  name         = var.dockerUserPassword
  key_vault_id = data.azurerm_key_vault.keyVault.id
}
data "azurerm_key_vault_secret" "fetched_secrets" {
  for_each = toset(var.secrets)
  name         = each.value
  key_vault_id = data.azurerm_key_vault.keyVault.id
}

resource "azurerm_key_vault_access_policy" "secret_policy" {
  key_vault_id = data.azurerm_key_vault.keyVault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azapi_resource.containerapp.identity[0].principal_id
  secret_permissions = [
    "Get"
  ]
}

locals {
  combined_secrets = zipmap(
    var.secrets, 
    [for s in var.secrets : lookup(data.azurerm_key_vault_secret.fetched_secrets[s], "versionless_id", null)]
  )
}
# resource "null_resource" "delaytest" {
#   provisioner "local-exec" {
#     command = "Start-Sleep -Seconds 60"
#     interpreter = ["PowerShell", "-Command"]
#   }
# }

resource "azapi_resource" "containerapp" {
  type = "Microsoft.App/containerApps@2023-05-01"
  name      = "${var.containerAppName}-${var.project}-${var.env}"
  parent_id =var.resourceGroupId
  tags = {
    project     = var.project
    Environment = var.env
  }
  location  = var.resourceGroupRegion
  response_export_values = ["properties.configuration.ingress.fqdn"]
  body = jsonencode({
    identity = {
      type = "SystemAssigned"
    }
    properties = {
      managedEnvironmentId = "${var.appEnvironmentId}"
      configuration = {
        activeRevisionsMode = "${var.revisionMode}"
        ingress = {
          external : true,
          allowInsecure : true,
          targetPort : 80,
        },
        registries = [{
          server            = "ghcr.io"
          username          = "${var.dockerUserName}"
          passwordSecretRef = "dockerpassword"
          # passwordSecretRef = {
          #   name       = "dockerpassword"
          #   value= "${data.azurerm_key_vault_secret.dockerpassword.value}" 
          #   //identity   = "system"
          #   //keyVaultUrl = "${data.azurerm_key_vault_secret.dockerpassword.versionless_id}"
          # }
        }]
        # secrets =  concat( [
        #     for secret_name, secret_value in local.combined_secrets :
        #     {
        #       name       = secret_name
        #       identity   = "system"
        #       keyVaultUrl = secret_value
        #     }
        #   ],
          secrets =[
        { 
          name  = "dockerpassword"
          # identity   = "system"
          # keyVaultUrl = "${data.azurerm_key_vault_secret.dockerpassword.versionless_id}"
          value = "${data.azurerm_key_vault_secret.dockerpassword.value}" 
        }]
        //)
      }
      template = {
        containers = [
          {
            name  = "${var.containerAppName}-container-${var.env}"
            image = "${var.dockerImage}"
            resources = {
              cpu    = "${var.containerCpuValue}"
              memory = "${var.containerMemoryValue}"
            }
            # env = [
            #   for key, secretRef in var.envVariables : {
            #     name      = key
            #     secretRef = secretRef
            #   }
            #   ]
          }
        ]
        scale = {
         maxReplicas = "${var.maxReplicas}"
         minReplicas = "${var.minReplicas}"
          rules = [
            {
              name = "cpu-scale-rule"
                custom= {
                  type= "cpu"
                  metadata = {
                    type= "Utilization"
                    value= "75"
                }
              }
            },
            {
              name = "memory-scale-rule"
                custom= {
                  type= "memory"
                  metadata = {
                    type= "Utilization"
                    value= "75"
                }
              }
            }
         ]
        }
      }
    }
  })
}
resource "null_resource" "delay" {
  depends_on = [ azapi_resource.containerapp ]
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "Start-Sleep -Seconds 200"
    interpreter = ["PowerShell", "-Command"]
  }
}
resource "azapi_update_resource" "containerappupdate" {
  type = "Microsoft.App/containerApps@2023-05-01"
  resource_id = azapi_resource.containerapp.id
  depends_on = [ null_resource.delay,azapi_resource.containerapp ]

   body = jsonencode({
      properties = {
      configuration = {
        secrets = [
            for secret_name, secret_value in local.combined_secrets :
            {
              name       = secret_name
              identity   = "system"
              keyVaultUrl = secret_value
            }
          ]
      }
      template = {
        containers = [
          {
            env = [
              for key, secretRef in var.envVariables : {
                name      = key
                secretRef = secretRef
              }
              ]
          }
        ]
       
      }

   
    }
  })
}
