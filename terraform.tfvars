//tags values
project = "proxy-container"
env     = "test"

//resource group values
# rgName   = "test_xyz"
# azRegion = "West US"

// storage account values must be a valid name
# storageAccountNames = [
#   "testappstorage1",
#   "testappstorage2",
#   "testappstorage3"
# ]


// appEnvironment values
appEnvironmentName = "test"

// logAnalytics Workspace values
logAnalyticsWorkspaceName = "logs"
// frontdoor values
# fdprofileName = "abcfrontdoor"
# customDomainName = "abc-xyz-app" //same name as domain but seprated with "-"
# domainHostName = "abc.xyz.app"  // actual domain name
# recordName= "abc"  // record name must be same as subdomain (abc as in case of abc.xyz.com)
# dnsZoneRG= "xyz-rg" // rg where zone exit
# dnsZoneName= "xyz.app" // name of zone

// container app values
dockerUserPassword = "dockerpassword"

apiscontainerapps = {
  apis = {
    containerAppName = "apis"
    keyVaultName     = "testapiskeyvault"
    min_replicas     = 1
    max_replicas     = 2
    docker_image     = "ghcr.io/xyz/orca-apis:dev"
    secrets = ["orcadatabase", "awsaccesskeyid", "awssecretaccesskey", "awsdefaultregion", "awsregion",
      "aspnetcoreenvironment", "mailfrom", "exportemailfrom", "documentprocessorserviceurl",
      "userpoolid", "clientid", "cognitossoappsecret", "samlredirecturi", "samltokenuri", "samlurl", "allowcorsurl",
      "notificationfromaddressesmailnotificationfrom", "notificationfromaddresseswebnotificationfrom", "accountsettingsserverlink",
      "indexingenginebaseurl", "indexingengineapikey", "documentconversionapikey",
    "documentconversionconversionbaseurl", "documentconversionconverterapiroute", "dockerpassword"]
    // "awsolangurl"
    env_variables = {
      "ORCADATABASE"           = "orcadatabase"
      "AWS_ACCESS_KEY_ID"      = "awsaccesskeyid"
      "AWS_SECRET_ACCESS_KEY"  = "awssecretaccesskey"
      "AWS_DEFAULT_REGION"     = "awsdefaultregion"
      "AWS__REGION"            = "awsregion"
      "ASPNETCORE_ENVIRONMENT" = "aspnetcoreenvironment"
      "MAILFROM"               = "mailfrom"
      "EXPORTEMAILFROM"        = "exportemailfrom"
      //"AWSOLANGURL"                                     = "awsolangurl"
      "DOCUMENTPROCESSORSERVICEURL"                     = "documentprocessorserviceurl"
      "USERPOOLID"                                      = "userpoolid"
      "CLIENTID"                                        = "clientid"
      "COGNITOSSOAPPSECRET"                             = "cognitossoappsecret"
      "SAMLREDIRECTURI"                                 = "samlredirecturi"
      "SAMLTOKENURI"                                    = "samltokenuri"
      "SAMLURL"                                         = "samlurl"
      "ALLOWCORSURL"                                    = "allowcorsurl"
      "NOTIFICATIONFROMADDRESSES__MAILNOTIFICATIONFROM" = "notificationfromaddressesmailnotificationfrom"
      "NOTIFICATIONFROMADDRESSES__WEBNOTIFICATIONFROM"  = "notificationfromaddresseswebnotificationfrom"
      "ACCOUNTSETTINGS__SERVERLINK"                     = "accountsettingsserverlink"
      "INDEXINGENGINE__BASEURL"                         = "indexingenginebaseurl"
      "INDEXINGENGINE__APIKEY"                          = "indexingengineapikey"
      "DOCUMENTCONVERSION__APIKEY"                      = "documentconversionapikey"
      "DOCUMENTCONVERSION__CONVERSIONBASEURL"           = "documentconversionconversionbaseurl"
      "DOCUMENTCONVERSION__CONVERTERAPIROUTE"           = "documentconversionconverterapiroute"
      "dockerpassword"                                  = "dockerpassword"
    }
  }
}
# olangcontainerapps = {
#   olang = {
#     containerAppName = "olang"
#     min_replicas     = 1
#     max_replicas     = 2
#     keyVaultName     = "olangkeyvault"
#     docker_image     = "ghcr.io/xyz/orca-proxy-server:latest"
#     secrets          = ["connectionstringproductiondb", "nerconfigbaseurl"]
#     env_variables = {
#       "CONNECTION_STRING_PRODUCTION-DB" = "connectionstringproductiondb"
#       "NERCONFIG__BASEURL"              = "nerconfigbaseurl"
#     }
#   }
# }
mutualizercontainerapps = {
  mutualizer = {
    containerAppName = "mutualizer"
    min_replicas     = 1
    max_replicas     = 2
    keyVaultName     = "mutualizerkeyvault"
    docker_image     = "ghcr.io/xyz/orca-proxy-server:latest"
    secrets          = ["apienv", "apikey", "openaiapitype", "openaiapibase", "openaiapiversion", "openaiapikey", "claudeapikey", "openaiapitypefinetuned", "openaiapibasefinetuned", "openaiapiversionfinetuned", "openaiapikeyfinetuned", "apimsubscriptionkey", "dockerpassword"]
    env_variables = {
      "API_ENV"                      = "apienv"
      "API_KEY"                      = "apikey"
      "OPENAI_API_TYPE"              = "openaiapitype"
      "OPENAI_API_BASE"              = "openaiapibase"
      "OPENAI_API_VERSION"           = "openaiapiversion"
      "OPENAI_API_KEY"               = "openaiapikey"
      "CLAUDE_API_KEY"               = "claudeapikey"
      "OPENAI_API_TYPE_FINETUNED"    = "openaiapitypefinetuned"
      "OPENAI_API_BASE_FINETUNED"    = "openaiapibasefinetuned"
      "OPENAI_API_VERSION_FINETUNED" = "openaiapiversionfinetuned"
      "OPENAI_API_KEY_FINETUNED"     = "openaiapikeyfinetuned"
      "APIM_SUBSCRIPTION_KEY"        = "apimsubscriptionkey"
      "dockerpassword"               = "dockerpassword"
    }
  }
}

# mailguncontainerapps={
#   mailgun = {
#     containerAppName = "mailgun"
#     keyVaultName     = "mailgunkeyvault"
#     min_replicas     = 1
#     max_replicas     = 2
#     docker_image     = "ghcr.io/xyz/orca-proxy-server:latest"
#     secrets          = ["orcadatabase", "awsaccesskeyid", "awssecretaccesskey", "awsdefaultregion", "awsregion", "apiusername", "apipassword", "userpoolid", "clientid", "betabaseurl", "betaapibaseurl", "buildbaseurl", "zendesksupportemail", "userlogurl", "weblandingpageurl"]
#     env_variables = {
#       "ORCADATABASE"          = "orcadatabase"
#       "AWS_ACCESS_KEY_ID"     = "awsaccesskeyid"
#       "AWS_SECRET_ACCESS_KEY" = "awssecretaccesskey"
#       "AWS_DEFAULT_REGION"    = "awsdefaultregion"
#       "AWS_REGION"            = "awsregion"
#       "APIUSERNAME"           = "apiusername"
#       "APIPASSWORD"           = "apipassword"
#       "USERPOOLID"            = "userpoolid"
#       "CLIENTID"              = "clientid"
#       "BETABASEURL"           = "betabaseurl"
#       "BETAAPIBASEURL"        = "betaapibaseurl"
#       "BUILDBASEURL"          = "buildbaseurl"
#       "ZENDESKSUPPORTEMAIL"   = "zendesksupportemail"
#       "USERLOGURL"            = "userlogurl"
#       "WEBLANDINGPAGEURL"     = "weblandingpageurl"
#     }
#   }
#   }

# workflowcontainerapps ={
#   workflow = {
#     containerAppName = "workflow"
#     keyVaultName     = "workflowkeyvault"
#     min_replicas     = 1
#     max_replicas     = 2
#     docker_image     = "ghcr.io/xyz/orca-proxy-server:latest"
#     secrets = ["awsaccesskeyid", "awssecretaccesskey", "awsdefaultregion", "awsregion", "awsregion", "connectionstringsorcadatabase", "apiusername",
#       "apipassword", "betaapibaseurl", "appbaseurl", "userlogurl", "clientbaseurl", "userpoolid", "clientid", "buildbaseurl", "betaapiroute",
#     "betabaseurl", "baseurl", "zendesksupportemail", "weblandingpageurl"]
#     env_variables = {
#       "AWS_ACCESS_KEY_ID"               = "awsaccesskeyid"
#       "AWS_SECRET_ACCESS_KEY"           = "awssecretaccesskey"
#       "AWS_DEFAULT_REGION"              = "awsdefaultregion"
#       "AWS_REGION"                      = "awsregion"
#       "AWS__REGION"                     = "awsregion"
#       "CONNECTIONSTRINGS__ORCADATABASE" = "connectionstringsorcadatabase"
#       "APIUSERNAME"                     = "apiusername"
#       "APIPASSWORD"                     = "apipassword"
#       "BETAAPIBASEURL"                  = "betaapibaseurl"
#       "APPBASEURL"                      = "appbaseurl"
#       "USERLOGURL"                      = "userlogurl"
#       "CLIENTBASEURL"                   = "clientbaseurl"
#       "USERPOOLID"                      = "userpoolid"
#       "CLIENTID"                        = "clientid"
#       "BUILDBASEURL"                    = "buildbaseurl"
#       "BETAAPIROUTE"                    = "betaapiroute"
#       "BETABASEURL"                     = "betabaseurl"
#       "BASEURL"                         = "baseurl"
#       "ZENDESKSUPPORTEMAIL"             = "zendesksupportemail"
#       "WEBLANDINGPAGEURL"               = "weblandingpageurl"
#     }
#   }
# }

# lawvucontainerapps={
#   lawvu = {
#     containerAppName = "lawvu"
#     min_replicas     = 1
#     max_replicas     = 2
#     keyVaultName     = "lawvukeyvault"
#     docker_image     = "ghcr.io/xyz/orca-proxy-server:latest"
#     secrets = ["connectionstringsdefaultconnection", "awsregion", "awsapiusername", "awsapipassword",
#               "awsuserpoolid", "awsclientid", "xyzbaseurl", "xyzintegrationheader", "lawvuauthorizationcodebaseurl",
#               "lawvuauthorizationcoderedirecturl", "lawvuauthorizationcodeusername", "lawvuauthorizationcodepassword", "lawvusubscriptionkey",
#               "lawvubaseurl", "applicationinsightsconnectionstring", "serilogwriteto0argsconnectionstring"]
#     env_variables = {
#       "CONNECTIONSTRINGS__DEFAULTCONNECTION"        = "connectionstringsdefaultconnection"
#       "AWS__REGION"                                 = "awsregion"
#       "AWS__APIUSERNAME"                            = "awsapiusername"
#       "AWS__APIPASSWORD"                            = "awsapipassword"
#       "AWS__USERPOOLID"                             = "awsuserpoolid"
#       "AWS__CLIENTID"                               = "awsclientid"
#       "xyz__BASEURL"                            = "xyzbaseurl"
#       "xyz__INTEGRATION-HEADER"                 = "xyzintegrationheader"
#       "LAWVU__AUTHORIZATIONCODE__BASEURL"           = "lawvuauthorizationcodebaseurl"
#       "LAWVU__AUTHORIZATIONCODE__REDIRECTURL"       = "lawvuauthorizationcoderedirecturl"
#       "LAWVU__AUTHORIZATIONCODE__USERNAME"          = "lawvuauthorizationcodeusername"
#       "LAWVU__AUTHORIZATIONCODE__PASSWORD"          = "lawvuauthorizationcodepassword"
#       "LAWVU__SUBSCRIPTIONKEY"                      = "lawvusubscriptionkey"
#       "LAWVU__BaseURL"                              = "lawvubaseurl"
#       "APPLICATIONINSIGHTS__CONNECTIONSTRING"       = "applicationinsightsconnectionstring"
#       "SERILOG__WRITETO__0__ARGS__CONNECTIONSTRING" = "serilogwriteto0argsconnectionstring"
#     }
#   }
# }

# olangcontainerapps = {
#   olang = {
#     containerAppName = "olang"
#     min_replicas     = 1
#     max_replicas     = 2
#     keyVaultName     = "olangkeyvault"
#     docker_image     = "ghcr.io/xyz/orca-proxy-server:latest"
#     secrets          = ["connectionstringproductiondb", "nerconfigbaseurl"]
#     env_variables = {
#       "CONNECTION_STRING_PRODUCTION-DB" = "connectionstringproductiondb"
#       "NERCONFIG__BASEURL"              = "nerconfigbaseurl"
#     }
#   }
# }

# proxycontainerapps={
#   proxy = {
#     containerAppName = "proxy"
#     min_replicas     = 1
#     max_replicas     = 2
#     keyVaultName     = "olangkeyvault"
#     docker_image     = "ghcr.io/xyz/orca-proxy-server:latest"
#   }
# }
