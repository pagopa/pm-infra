data "azurerm_resource_group" "appgw_rg" {
  name = var.appgw_rg
}

resource "azurerm_public_ip" "publicip" {
  count               = var.environment != "pft" ? 1 : 0
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
  count                = var.environment != "pft" ? 1 : 0
  name                 = format("%s-subnet-%s", var.appgw_subnet_name, var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = var.vnet_outgoing_name
  address_prefixes     = [data.azurerm_key_vault_secret.appgw-subnet-address-space.value]
}

# data "azurerm_subnet" "appgw_subnet" {
#   name                 = format("%s-subnet-%s", var.appgw_subnet_name, var.environment)
#   resource_group_name  = data.azurerm_resource_group.rg_vnet.name
#   virtual_network_name = var.vnet_outgoing_name
# }

locals {
  s4s_address = split(",", data.azurerm_key_vault_secret.s4s-address.value)
  # appgw_context = var.appgw_context != [] ? var.appgw_context : var.environment
}

resource "azurerm_application_gateway" "appgw" {
  count               = var.environment != "pft" ? 1 : 0
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

  dynamic "backend_address_pool" {
    for_each = var.appgw_context

    content {
      fqdns = [
        format("pm-appsrv-admin-panel-%s.azurewebsites.net", backend_address_pool.value)
      ]
      name = format("pm-jboss-%s", backend_address_pool.value)
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.appgw_context

    content {
      fqdns = [
        format("pm-appsrv-admin-panel-%s.azurewebsites.net", backend_address_pool.value)
      ]
      name = format("pm-appsrv-admin-panel-%s", backend_address_pool.value)
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.appgw_context

    content {
      fqdns = [
        format("pm-appsrv-batch-%s.azurewebsites.net", backend_address_pool.value)
      ]
      name = format("pm-appsrv-batch-%s", backend_address_pool.value)
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.appgw_context

    content {
      fqdns = [
        format("pm-appsrv-logging-%s.azurewebsites.net", backend_address_pool.value)
      ]
      name = format("pm-appsrv-logging-%s", backend_address_pool.value)
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.appgw_context

    content {
      fqdns = [
        format("pm-appsrv-restapi-io-%s.azurewebsites.net", backend_address_pool.value)
      ]
      name = format("pm-appsrv-restapi-io-%s", backend_address_pool.value)
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.appgw_context

    content {
      fqdns = [
        format("pm-appsrv-rtd-%s.azurewebsites.net", backend_address_pool.value)
      ]
      name = format("pm-appsrv-rtd-%s", backend_address_pool.value)
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.appgw_context

    content {
      fqdns = [
        format("pm-appsrv-wisp-%s.azurewebsites.net", backend_address_pool.value)
      ]
      name = format("pm-appsrv-wisp-%s", backend_address_pool.value)
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.appgw_context

    content {
      fqdns = [
        format("pm-appsrv-restapi-%s.azurewebsites.net", backend_address_pool.value)
      ]
      name = format("pm-appsrv-restapi-%s", backend_address_pool.value)
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.appgw_context

    content {
      fqdns = [
        format("pm-appsrv-payment-gateway-%s.azurewebsites.net", backend_address_pool.value)
      ]
      name = format("pm-appsrv-payment-gateway-%s", backend_address_pool.value)
    }
  }

  backend_address_pool {
    ip_addresses = local.s4s_address
    name         = "s4sonprem"
  }

  # dynamic "backend_address_pool" {
  #   for_each = var.appgw_context

  #   content {
  #     ip_addresses = local.s4s_address
  #     name         = format("s4sonprem-%s", backend_address_pool.value)
  #   }
  # }

  dynamic "backend_http_settings" {
    for_each = var.appgw_context

    content {
      affinity_cookie_name  = "ApplicationGatewayAffinity"
      cookie_based_affinity = "Enabled"
      # host_name                           = var.backend_http_settings_host_name
      name                                = "pm-${backend_http_settings.value}-http-setting"
      pick_host_name_from_backend_address = true
      port                                = 80
      protocol                            = "Http"
      request_timeout                     = 20
      trusted_root_certificate_names      = []
    }
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
    name                          = azurerm_public_ip.publicip[count.index].name
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip[count.index].id
  }

  frontend_ip_configuration {
    name                          = "pm-private-feip"
    private_ip_address            = data.azurerm_key_vault_secret.appgw-private-ip-address.value
    private_ip_address_allocation = "Static"
    subnet_id                     = azurerm_subnet.appgw_subnet[count.index].id
  }

  dynamic "frontend_port" {
    for_each = range(length(var.appgw_context))
    content {
      name = format("port_%d", 80 + frontend_port.value)
      port = format("%d", 80 + frontend_port.value)
    }
  }
  dynamic "frontend_port" {
    for_each = range(length(var.appgw_context))
    content {
      name = format("port_%d", 8080 + frontend_port.value)
      port = format("%d", 8080 + frontend_port.value)
    }
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
    subnet_id = azurerm_subnet.appgw_subnet[count.index].id
  }

  dynamic "http_listener" {
    for_each = var.appgw_context

    content {
      frontend_ip_configuration_name = "pm-private-feip"
      frontend_port_name             = format("port_%d", 80 + http_listener.key)
      name                           = "pm-${http_listener.value}-listener"
      protocol                       = "Http"
      require_sni                    = false
    }
  }

  dynamic "http_listener" {
    for_each = var.appgw_context

    content {
      frontend_ip_configuration_name = "pm-private-feip"
      frontend_port_name             = format("port_%d", 8080 + http_listener.key)
      name                           = "listener_private_context_${http_listener.value}"
      protocol                       = "Http"
      require_sni                    = false

    }
  }


  http_listener {
    frontend_ip_configuration_name = "pm-private-feip"
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
    protocol            = "Http"
    timeout             = "30"
    unhealthy_threshold = "3"
  }

  dynamic "probe" {
    for_each = var.appgw_context

    content {
      #host                                      = var.backend_http_settings_host_name
      interval                                  = 30
      minimum_servers                           = 0
      name                                      = "pm-${probe.value}-http-setting"
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
  }

  dynamic "request_routing_rule" {
    for_each = var.appgw_context

    content {
      backend_address_pool_name  = "${var.backend_address_pool_name}-${request_routing_rule.value}"
      backend_http_settings_name = "pm-${request_routing_rule.value}-http-setting"
      http_listener_name         = "pm-${request_routing_rule.value}-listener"
      name                       = "pm-${request_routing_rule.value}-routing"
      rewrite_rule_set_name      = "rewrite_private"
      rule_type                  = "Basic"
      priority                   = format("%s", "3" + request_routing_rule.key)
    }
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
    priority                   = "15"
    rule_type                  = "Basic"
  }

  dynamic "request_routing_rule" {
    for_each = var.appgw_context
    content {
      http_listener_name = "listener_private_context_${request_routing_rule.value}"
      name               = "routing_private_context_${request_routing_rule.value}"
      priority           = format("%s", "1" + request_routing_rule.key)
      rule_type          = "PathBasedRouting"
      url_path_map_name  = "routing_private_context_${request_routing_rule.value}"
    }
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

  dynamic "url_path_map" {
    for_each = var.appgw_context

    content {
      default_backend_address_pool_name  = format("pm-jboss-%s", url_path_map.value)
      default_backend_http_settings_name = "pm-${url_path_map.value}-http-setting"
      default_rewrite_rule_set_name      = "rewrite_private_context"
      name                               = "routing_private_context_${url_path_map.value}"

      path_rule {
        backend_address_pool_name  = format("pm-appsrv-restapi-%s", url_path_map.value)
        backend_http_settings_name = "pm-${url_path_map.value}-http-setting"
        name                       = "pp-restapi-${url_path_map.value}"
        paths = [
          format("/pp-restapi%s/*", replace(url_path_map.value, "uat", "")),
        ]
        rewrite_rule_set_name = "rewrite_private_context"
      }

      path_rule {
        backend_address_pool_name  = format("pm-appsrv-admin-panel-%s", url_path_map.value)
        backend_http_settings_name = "pm-${url_path_map.value}-http-setting"
        name                       = "admin-panel-${url_path_map.value}"
        paths = [
          format("/pp-admin-panel%s/*", replace(url_path_map.value, "uat", "")),
        ]
        rewrite_rule_set_name = "rewrite_private_context"
      }

      path_rule {
        backend_address_pool_name  = format("pm-appsrv-restapi-io-%s", url_path_map.value)
        backend_http_settings_name = "pm-${url_path_map.value}-http-setting"
        name                       = "pp-restapi-CD-${url_path_map.value}"
        paths = [
          format("/pp-restapi-CD%s/*", replace(url_path_map.value, "uat", "")),
        ]
        rewrite_rule_set_name = "rewrite_private_context"
      }

      path_rule {
        backend_address_pool_name  = format("pm-appsrv-wisp-%s", url_path_map.value)
        backend_http_settings_name = "pm-${url_path_map.value}-http-setting"
        name                       = "wallet-${url_path_map.value}"
        paths = [
          format("/wallet%s/*", replace(url_path_map.value, "uat", "")),
        ]
        rewrite_rule_set_name = "rewrite_private_context"
      }

      path_rule {
        backend_address_pool_name  = format("pm-appsrv-restapi-%s", url_path_map.value)
        backend_http_settings_name = "pm-${url_path_map.value}-http-setting"
        name                       = "pp-restapi-server-${url_path_map.value}"
        paths = [
          format("/pp-restapi-server%s/*", replace(url_path_map.value, "uat", "")),
        ]
        rewrite_rule_set_name = "rewrite_private_context"
      }

      path_rule {
        backend_address_pool_name  = format("pm-appsrv-rtd-%s", url_path_map.value)
        backend_http_settings_name = "pm-${url_path_map.value}-http-setting"
        name                       = "pp-restapi-rtd-${url_path_map.value}"
        paths = [
          format("/pp-restapi-rtd%s/*", replace(url_path_map.value, "uat", "")),
        ]
        rewrite_rule_set_name = "rewrite_private_context"
      }

      path_rule {
        backend_address_pool_name  = format("pm-appsrv-logging-%s", url_path_map.value)
        backend_http_settings_name = "pm-${url_path_map.value}-http-setting"
        name                       = "db-logging-${url_path_map.value}"
        paths = [
          format("/db-logging%s/*", replace(url_path_map.value, "uat", "")),
        ]
        rewrite_rule_set_name = "rewrite_private_context"
      }

      path_rule {
        backend_address_pool_name  = format("pm-appsrv-batch-%s", url_path_map.value)
        backend_http_settings_name = "pm-${url_path_map.value}-http-setting"
        name                       = "pp-ejbBatch-${url_path_map.value}"
        paths = [
          format("/pp-ejbBatch%s/*", replace(url_path_map.value, "uat", "")),
        ]
        rewrite_rule_set_name = "rewrite_private_context"
      }

      path_rule {
        backend_address_pool_name  = format("pm-appsrv-payment-gateway-%s", url_path_map.value)
        backend_http_settings_name = "pm-${url_path_map.value}-http-setting"
        name                       = "payment-gateway-${url_path_map.value}"
        paths = [
          format("/payment-gateway%s/*", replace(url_path_map.value, "uat", "")),
        ]
        rewrite_rule_set_name = "rewrite_private_context"
      }
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