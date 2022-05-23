data "azurerm_resource_group" "appgw_rg" {
  name     = var.appgw_rg
}

resource "azurerm_public_ip" "publicip" {
  name                = format("pm-appsrv-%s-public-ip", var.environment)
  resource_group_name = data.azurerm_resource_group.appgw_rg.name
  location            = data.azurerm_resource_group.appgw_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard,
    TS_Code     = var.tsi,
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_subnet" "appgw_subnet" {
  name                 = format("%s-subnet-%s", var.appgw_subnet_name, var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = var.vnet_outgoing_name
  address_prefixes     = [data.azurerm_key_vault_secret.appgw-subnet-address-space.value]
}

locals {
  s4s_address = split(",", data.azurerm_key_vault_secret.s4s-address.value)
}

resource "azurerm_application_gateway" "appgw" {
  # depends_on          = [module.web_app, azurerm_private_endpoint.inbound-endpt]
  enable_http2        = false
  location            = data.azurerm_resource_group.appgw_rg.location
  name                = format("%s-PM-AppGateway-%s-%s", var.prefix, var.standard, var.environment)
  resource_group_name = data.azurerm_resource_group.appgw_rg.name

  tags = {
    kind        = "network",
    environment = var.environment,
    standard    = var.standard,
    TS_Code     = var.tsi,
    CreatedBy   = "Terraform"
  }
  
  backend_address_pool {
    fqdns = [
      format("%s.azurewebsites.net", module.admin-panel.name)
    ]
    name = format("pm-jboss-%s", var.environment)
  }

  backend_address_pool {
    fqdns = [
      format("%s.azurewebsites.net", module.admin-panel.name)
    ]
    name = module.admin-panel.name
  }

  backend_address_pool {
    fqdns = [
      format("%s.azurewebsites.net", module.batch.name)
    ]
    name = module.batch.name
  }

  backend_address_pool {
    fqdns = [
      format("%s.azurewebsites.net", module.logging.name)
    ]
    name = module.logging.name
  }

  backend_address_pool {
    fqdns = [
      format("%s.azurewebsites.net", module.restapi-io.name)
    ]
    name = module.restapi-io.name
  }

  backend_address_pool {
    fqdns = [
      format("%s.azurewebsites.net", module.restapi.name)
    ]
    name = module.restapi.name
  }

  backend_address_pool {
    fqdns = [
      format("%s.azurewebsites.net", module.rtd.name)
    ]
    name = module.rtd.name
  }

  backend_address_pool {
    fqdns = [
      format("%s.azurewebsites.net", module.wisp.name)
    ]
    name = module.wisp.name
  }

    backend_address_pool {
    fqdns = [
      format("%s.azurewebsites.net", "pm-appsrv-payment-gateway-${var.environment}")
    ]    
    name  = "pm-appsrv-payment-gateway-${var.environment}"
  }

  backend_address_pool {
    ip_addresses = local.s4s_address
    name         = "s4sonprem"
  }

  backend_http_settings {
    affinity_cookie_name  = "ApplicationGatewayAffinity"
    cookie_based_affinity = "Enabled"
    # host_name                           = var.backend_http_settings_host_name
    name                                = "pm-${var.environment}-http-setting"
    pick_host_name_from_backend_address = true
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 20
    trusted_root_certificate_names      = []
  }

  backend_http_settings {
    cookie_based_affinity               = "Disabled"
    name                                = "s4shttp"
    pick_host_name_from_backend_address = "false"
    port                                = "8240"
    probe_name                          = "s4sprobe"
    protocol                            = "Http"
    request_timeout                     = "120"
  }

  frontend_ip_configuration {
    name                          = azurerm_public_ip.publicip.name
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }

  frontend_ip_configuration {
    name                          = "pm-${var.environment}-feip"
    private_ip_address            = data.azurerm_key_vault_secret.appgw-private-ip-address.value
    private_ip_address_allocation = "Static"
    subnet_id                     = azurerm_subnet.appgw_subnet.id
  }

  frontend_port {
    name = "port_80"
    port = 80
  }
  frontend_port {
    name = "port_8080"
    port = 8080
  }
  frontend_port {
    name = "port_8181"
    port = 8181
  }
  frontend_port {
    name = "port_8240"
    port = "8240"
  }
  # frontend_port {
  #   name = "port_8282"
  #   port = 8282
  # }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.appgw_subnet.id
  }

  http_listener {
    frontend_ip_configuration_name = "pm-${var.environment}-feip"
    frontend_port_name             = "port_80"
    name                           = "pm-${var.environment}-listener"
    protocol                       = "Http"
    require_sni                    = false
  }
  http_listener {
    frontend_ip_configuration_name = "pm-${var.environment}-feip"
    frontend_port_name             = "port_8080"
    name                           = "listener_private_context"
    protocol                       = "Http"
    require_sni                    = false
  }

  http_listener {
    frontend_ip_configuration_name = "pm-${var.environment}-feip"
    frontend_port_name             = "port_8240"
    name                           = "s4s_gateway"
    protocol                       = "Http"
    require_sni                    = "false"
  }

  # http_listener {
  #   frontend_ip_configuration_name = "pm-${var.environment}-feip"
  #   frontend_port_name             = "port_8282"
  #   name                           = "pm-${var.environment}-private-listener"
  #   protocol                       = "Http"
  #   require_sni                    = "false"
  # }

  # S4S Probe
  probe {
    host                                      = "127.0.0.1"
    interval                                  = "30"
    minimum_servers                           = "0"
    name                                      = "s4sprobe"
    path                                      = "/"
    pick_host_name_from_backend_http_settings = "false"
    #port                                      = "0"
    protocol                                  = "Http"
    timeout                                   = "30"
    unhealthy_threshold                       = "3"
  }

  probe {
    #host                                      = var.backend_http_settings_host_name
    interval                                  = 30
    minimum_servers                           = 0
    name                                      = "pm-${var.environment}-http-setting"
    path                                      = "/"
    pick_host_name_from_backend_http_settings = true
    #port                                      = 0
    protocol            = "Http"
    timeout             = 30
    unhealthy_threshold = 3

    match {
      status_code = [
        "200-399",
      ]
    }
  }

  request_routing_rule {
    backend_address_pool_name  = "${var.backend_address_pool_name}-${var.environment}"
    backend_http_settings_name = "pm-${var.environment}-http-setting"
    http_listener_name         = "pm-${var.environment}-listener"
    name                       = "pm-${var.environment}-routing"
    rewrite_rule_set_name      = "rewrite_private"
    rule_type                  = "Basic"
    priority                   = "3"
  }

  # request_routing_rule {
  #   backend_address_pool_name  = "${var.backend_address_pool_name}-${var.environment}"
  #   backend_http_settings_name = "pm-${var.environment}-http-setting"
  #   http_listener_name         = "pm-${var.environment}-private-listener"
  #   name                       = "pm-${var.environment}-routing-private"
  #   rewrite_rule_set_name      = "rewrite_private_context"
  #   rule_type                  = "PathBasedRouting"
  #   url_path_map_name          = "routing_private_context"
  #   priority                   = "2"
  # }

  request_routing_rule {
    backend_address_pool_name  = "s4sonprem"
    backend_http_settings_name = "s4shttp"
    http_listener_name         = "s4s_gateway"
    name                       = "s4srouting"
    priority                   = "5"
    rule_type                  = "Basic"
  }

  request_routing_rule {
    http_listener_name = "listener_private_context"
    name               = "routing_private_context"
    priority           = "1"
    rule_type          = "PathBasedRouting"
    url_path_map_name  = "routing_private_context"
  }

  rewrite_rule_set {
    name = "rewrite_private"

    rewrite_rule {
      condition {
        ignore_case = "true"
        negate      = "false"
        pattern     = "(.*)Domain=pm-appsrv-admin-panel-sit.azurewebsites.net"
        variable    = "http_resp_Set-Cookie"
      }

      name = "NewRewrite"

      response_header_configuration {
        header_name  = "Set-Cookie"
        header_value = "{http_resp_Set-Cookie_1};Domain=api.dev.platform.pagopa.it"
      }

      rule_sequence = "100"
    }

    rewrite_rule {
      condition {
        ignore_case = "true"
        negate      = "false"
        pattern     = "(https?):\\/\\/.*:80/(.*)$"
        variable    = "http_resp_Location"
      }

      name = "NewRewrite"

      response_header_configuration {
        header_name  = "Location"
        header_value = "https://api.dev.platform.pagopa.it/{http_resp_Location_2}"
      }

      rule_sequence = "100"
    }

    rewrite_rule {
      condition {
        ignore_case = "true"
        negate      = "false"
        pattern     = "(https?):\\/\\/.*azurewebsites\\.net/(.*)$"
        variable    = "http_resp_Location"
      }

      name = "NewRewrite"

      response_header_configuration {
        header_name  = "Location"
        header_value = "https://api.dev.platform.pagopa.it/{http_resp_Location_2}"
      }

      rule_sequence = "100"
    }
  }

  rewrite_rule_set {
    name = "rewrite_private_context"

    rewrite_rule {
      condition {
        ignore_case = "true"
        negate      = "false"
        pattern     = "(https?):\\/\\/.*:80/(.*)$"
        variable    = "http_resp_Location"
      }

      name = "NewRewrite"

      response_header_configuration {
        header_name  = "Location"
        header_value = "https://api.dev.platform.pagopa.it/{http_resp_Location_2}"
      }

      rule_sequence = "100"
    }

    rewrite_rule {
      condition {
        ignore_case = "true"
        negate      = "false"
        pattern     = "(https?):\\/\\/.*azurewebsites\\.net/(.*)$"
        variable    = "http_resp_Location"
      }

      name = "NewRewrite"

      response_header_configuration {
        header_name  = "Location"
        header_value = "https://api.dev.platform.pagopa.it/{http_resp_Location_2}"
      }

      rule_sequence = "100"
    }
  }

  ssl_policy {
    policy_name = "AppGwSslPolicy20150501"
    policy_type = "Predefined"
  }

  url_path_map {
    default_backend_address_pool_name  = format("pm-jboss-%s", var.environment)
    default_backend_http_settings_name = "pm-${var.environment}-http-setting"
    default_rewrite_rule_set_name      = "rewrite_private_context"
    name                               = "routing_private_context"

    path_rule {
      backend_address_pool_name  = module.restapi.name
      backend_http_settings_name = "pm-${var.environment}-http-setting"
      name                       = "pp-restapi"
      paths = [
        "/pp-restapi/*",
      ]
      rewrite_rule_set_name = "rewrite_private_context"
    }
    path_rule {
      backend_address_pool_name  = module.admin-panel.name
      backend_http_settings_name = "pm-${var.environment}-http-setting"
      name                       = "admin-panel"
      paths = [
        "/pp-admin-panel/*",
      ]
      rewrite_rule_set_name = "rewrite_private_context"
    }
    path_rule {
      backend_address_pool_name  = module.restapi-io.name
      backend_http_settings_name = "pm-${var.environment}-http-setting"
      name                       = "pp-restapi-CD"
      paths = [
        "/pp-restapi-CD/*",
      ]
      rewrite_rule_set_name = "rewrite_private_context"
    }
    path_rule {
      backend_address_pool_name  = module.wisp.name
      backend_http_settings_name = "pm-${var.environment}-http-setting"
      name                       = "wallet"
      paths = [
        "/wallet/*",
      ]
      rewrite_rule_set_name = "rewrite_private_context"
    }
    path_rule { # ENSURE: ok??
      backend_address_pool_name  = module.restapi.name
      backend_http_settings_name = "pm-${var.environment}-http-setting"
      name                       = "pp-restapi-server"
      paths = [
        "/pp-restapi-server/*",
      ]
      rewrite_rule_set_name = "rewrite_private_context"
    }
    path_rule {
      backend_address_pool_name  = module.rtd.name
      backend_http_settings_name = "pm-${var.environment}-http-setting"
      name                       = "pp-restapi-rtd"
      paths = [
        "/pp-restapi-rtd/*",
      ]
      rewrite_rule_set_name = "rewrite_private_context"
    }
    path_rule {
      backend_address_pool_name  = module.logging.name
      backend_http_settings_name = "pm-${var.environment}-http-setting"
      name                       = "db-logging"
      paths = [
        "/db-logging/*",
      ]
      rewrite_rule_set_name = "rewrite_private_context"
    }
    path_rule {
      backend_address_pool_name  = module.batch.name
      backend_http_settings_name = "pm-${var.environment}-http-setting"
      name                       = "pp-ejbBatch"
      paths = [
        "/pp-ejbBatch/*",
      ]
      rewrite_rule_set_name = "rewrite_private_context"
    }
    path_rule {
      backend_address_pool_name  = "pm-appsrv-payment-gateway-${var.environment}"
      backend_http_settings_name = "pm-${var.environment}-http-setting"
      name                       = "payment-gateway"
      paths                      = ["/payment-gateway/*"]
      rewrite_rule_set_name      = "rewrite_private_context"
    }
  }


  sku {
    capacity = var.appgw_sku_capacity
    name     = "WAF_v2"
    tier     = "WAF_v2"
  }

  timeouts {}

  waf_configuration {
    enabled                  = false
    file_upload_limit_mb     = 100
    firewall_mode            = "Detection"
    max_request_body_size_kb = 128
    request_body_check       = true
    rule_set_type            = "OWASP"
    rule_set_version         = "3.0"
  }
}