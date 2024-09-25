resource "random_id" "fdendpointname" {
  byte_length = 8
}

resource "azurerm_cdn_frontdoor_profile" "frontdoor" {
  name                     = var.fdprofileName
  resource_group_name      = var.resourceGroupName
  sku_name                 = var.fdSkuName
  response_timeout_seconds = var.responseTimeout
  tags = {
    project     = var.project
    environment = var.env
  }
}

resource "azurerm_cdn_frontdoor_endpoint" "defaultendpoint" {
  name                     = "fdendpoint-${lower(random_id.fdendpointname.hex)}"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id
  tags = {
    project     = var.project
    environment = var.env
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "defaultorigingroup" {
  name                     = "${var.project}-OriginGroup-${var.env}"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id
  session_affinity_enabled = false

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin" "defaultorigin" {
  name                          = "${var.project}-Origin-${var.env}"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.defaultorigingroup.id

  enabled                        = true
  host_name                      = var.appContainerUrl
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = var.appContainerUrl
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_route" "defaultroute" {
  depends_on = [azurerm_cdn_frontdoor_origin_group.defaultorigingroup,azurerm_cdn_frontdoor_origin.defaultorigin]//, azurerm_cdn_frontdoor_rule_set.defaultruleset]

  name                          = "${var.project}-Route-${var.env}"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.defaultendpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.defaultorigingroup.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.defaultorigin.id]
  //cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.defaultruleset.id]

  enabled = true
  forwarding_protocol    = "HttpOnly" /// add the HTTPS for testing
  https_redirect_enabled = false
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.defaultcustomdomian.id]
  link_to_default_domain = true
}

resource "azurerm_cdn_frontdoor_rule_set" "defaultruleset" {
   name                     = var.fdRuleSetName
   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id
 }

resource "azurerm_cdn_frontdoor_rule" "defaultrule" {
   depends_on = [azurerm_cdn_frontdoor_origin_group.defaultorigingroup, azurerm_cdn_frontdoor_origin.defaultorigin]

   name                      = var.fdRuleName
   cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.defaultruleset.id
   order                     = 0
   behavior_on_match         = "Continue"
   conditions {
     request_uri_condition {
       operator         = "Contains"
       negate_condition = false
       match_values     = ["prod.xyz.app/xyz/"]
     }
   }
   actions {
     url_redirect_action {
       redirect_type        = "PermanentRedirect"
       destination_path     = "/"
       destination_hostname = "xyz.app"
     }
   }
 }

data "azurerm_dns_zone" "zone" {
  provider = azurerm.production
  name                = var.dnsZoneName 
  resource_group_name = var.dnsZoneRG 
}
resource "azurerm_cdn_frontdoor_custom_domain" "defaultcustomdomian" {
  name                     = var.customDomainName
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id
  dns_zone_id = data.azurerm_dns_zone.zone.id
  host_name                = var.domainHostName
  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}
resource "azurerm_dns_txt_record" "txtrecord" {
  provider = azurerm.production
  name                = join(".", ["_dnsauth", "${var.recordName}"])
  zone_name           = data.azurerm_dns_zone.zone.name 
  resource_group_name = data.azurerm_dns_zone.zone.resource_group_name
  ttl                 = 300
  record {
    value = azurerm_cdn_frontdoor_custom_domain.defaultcustomdomian.validation_token
  }
  lifecycle {
    ignore_changes = [
      record
    ]
  }
}
resource "azurerm_dns_cname_record" "cnamerecord" {
  provider = azurerm.production
  name                = var.recordName
  zone_name           = data.azurerm_dns_zone.zone.name 
  resource_group_name = data.azurerm_dns_zone.zone.resource_group_name
  ttl                 = 900
  record              = azurerm_cdn_frontdoor_endpoint.defaultendpoint.host_name
}


//Creating Web Application Firewall policy for Frontdoor

 resource "azurerm_cdn_frontdoor_firewall_policy" "defaultwafpolicy" {
   name                              = "${var.project}-Waf-policy-${var.env}"
   resource_group_name = var.resourceGroupName
   sku_name                          = azurerm_cdn_frontdoor_profile.frontdoor.sku_name
   enabled                           = true
   mode                              = "Detection"
   managed_rule {
     type    = "Microsoft_BotManagerRuleSet"
     version = "1.0"
     action  = "Log"
   }
   managed_rule {
     type    = "Microsoft_DefaultRuleSet"
     version = "2.1"
     action = "block"
   }
   tags = {
     project= var.project
     environment = var.env
   }
 }

 resource "azurerm_cdn_frontdoor_security_policy" "defaultsecuritypolicy" {
   name                     = "${var.project}-Security-Policy-${var.env}"
   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id

   security_policies {
     firewall {
       cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.defaultwafpolicy.id

       association {
         domain {
           cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_custom_domain.defaultcustomdomian.id

         }
         patterns_to_match = ["/*"]
       }
     }
   }
 }

