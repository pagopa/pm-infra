resource "azurerm_resource_group" "appgw_rg" {
  name     = var.appgw_rg
  location = var.location
}

resource "azurerm_public_ip" "publicip" {
  name                = format("pm-appsrv-%s-public-ip", var.environment)
  resource_group_name = azurerm_resource_group.appgw_rg.name
  location            = azurerm_resource_group.appgw_rg.location
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
  name                 = format("%s-%s", var.appgw_subnet_name, var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = var.vnet_outgoing_name
  address_prefixes     = [data.azurerm_key_vault_secret.appgw-subnet-address-space.value]
}

resource "azurerm_application_gateway" "appgw" {
  # depends_on          = [module.web_app, azurerm_private_endpoint.inbound-endpt]
  enable_http2        = false
  location            = azurerm_resource_group.appgw_rg.location
  name                = "${var.appgw_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.appgw_rg.name

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
    name = "port_8282"
    port = 8282
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.appgw_subnet.id
  }

  http_listener {
    frontend_ip_configuration_name = azurerm_public_ip.publicip.name
    frontend_port_name             = "port_80"
    name                           = "pm-${var.environment}-listener"
    protocol                       = "Http"
    require_sni                    = false
  }
  http_listener {
    frontend_ip_configuration_name = "pm-${var.environment}-feip"
    frontend_port_name             = "port_8080"
    name                           = "pm-${var.environment}-private-listener"
    protocol                       = "Http"
    require_sni                    = false
  }
  # http_listener {
  #   frontend_ip_configuration_name = "pm-${var.environment}-feip"
  #   frontend_port_name             = "port_8282"
  #   name                           = "pm-${var.environment}-private-listener"
  #   protocol                       = "Http"
  #   require_sni                    = false
  # }


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

  rewrite_rule_set {
    name = "rewrite_location"

    rewrite_rule {
      name          = "NewRewrite"
      rule_sequence = 100

      condition {
        ignore_case = true
        negate      = false
        pattern     = "(https?):\\/\\/.*azurewebsites\\.net/(.*)$"
        variable    = "http_resp_Location"
      }

      response_header_configuration {
        header_name  = "Location"
        header_value = "{http_resp_Location_1}://api.dev.platform.pagopa.it/{http_resp_Location_2}"
      }
    }
    rewrite_rule {
      name          = "NewRewrite"
      rule_sequence = 100

      condition {
        ignore_case = true
        negate      = false
        pattern     = "(https?):\\/\\/.*:80/(.*)$"
        variable    = "http_resp_Location"
      }

      response_header_configuration {
        header_name  = "Location"
        header_value = "https://api.dev.platform.pagopa.it/{http_resp_Location_2}"
      }
    }
    rewrite_rule {
      name          = "NewRewrite"
      rule_sequence = 100

      condition {
        ignore_case = true
        negate      = false
        pattern     = "(.*)Domain=pm-appsrv-admin-panel-sit.azurewebsites.net"
        variable    = "http_resp_Set-Cookie"
      }

      response_header_configuration {
        header_name  = "Set-Cookie"
        header_value = "{http_resp_Set-Cookie_1};Domain=api.dev.platform.pagopa.it"
      }
    }
  }
  rewrite_rule_set {
    name = "rewrite_private_context"

    rewrite_rule {
      name          = "Riscrivi Dominio"
      rule_sequence = 100

      condition {
        ignore_case = true
        negate      = false
        pattern     = "(https?):\\/\\/.*azurewebsites\\.net/(.*)$"
        variable    = "http_resp_Location"
      }

      response_header_configuration {
        header_name  = "Location"
        header_value = "https://${data.azurerm_key_vault_secret.apim-public-ip.value}/{http_resp_Location_2}"
      }
    }
    rewrite_rule {
      name          = "Elimina Porta 80"
      rule_sequence = 100

      condition {
        ignore_case = true
        negate      = false
        pattern     = "(https?):\\/\\/.*:80/(.*)$"
        variable    = "http_resp_Location"
      }

      response_header_configuration {
        header_name  = "Location"
        header_value = "https://${data.azurerm_key_vault_secret.apim-public-ip.value}/{http_resp_Location_2}"
      }
    }
  }
  # request_routing_rule { TODO: REVISIONE
  #   http_listener_name = "listener_private_context"
  #   name               = "routing_private_context"
  #   priority           = 0
  #   rule_type          = "PathBasedRouting"
  #   url_path_map_name  = "routing_private_context"
  # }
  # request_routing_rule {
  #   backend_address_pool_name  = "pm-jboss-sit"
  #   backend_http_settings_name = "pm-sit-http-setting"
  #   http_listener_name         = "pm-sit-listener"
  #   name                       = "pm-sit-routing"
  #   priority                   = 0
  #   rule_type                  = "Basic"
  # }
  # request_routing_rule {
  #   backend_address_pool_name  = "pm-jboss-sit"
  #   backend_http_settings_name = "pm-sit-http-setting"
  #   http_listener_name         = "pm-sit-private-listener"
  #   name                       = "pm-sit-routing-private"
  #   priority                   = 0
  #   rewrite_rule_set_name      = "rewrite_private"
  #   rule_type                  = "Basic"
  # }

  request_routing_rule {
    backend_address_pool_name  = "${var.backend_address_pool_name}-${var.environment}"
    backend_http_settings_name = "pm-${var.environment}-http-setting"
    http_listener_name         = "pm-${var.environment}-listener"
    name                       = "pm-${var.environment}-routing"
    rewrite_rule_set_name      = "rewrite_location"
    rule_type                  = "Basic"
  }
  request_routing_rule {
    backend_address_pool_name  = "${var.backend_address_pool_name}-${var.environment}"
    backend_http_settings_name = "pm-${var.environment}-http-setting"
    http_listener_name         = "pm-${var.environment}-private-listener"
    name                       = "pm-${var.environment}-routing-private"
    rewrite_rule_set_name      = "rewrite_private_context"
    rule_type                  = "PathBasedRouting"
    url_path_map_name          = "routing_private_context"
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
    path_rule { # TODO: Da verificare
      backend_address_pool_name  = format("pm-jboss-%s", var.environment)
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
  }


  sku {
    capacity = var.appgw_sku_capacity
    name     = var.appgw_sku_size
    tier     = var.appgw_sku_size
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