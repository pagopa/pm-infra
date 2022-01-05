resource "azurerm_resource_group" "appgw_rg" {
  name     = var.appgw_rg
  location = var.location
}

data "azurerm_resource_group" "rg_vnet" {
  name = var.network_resource
}

resource "azurerm_public_ip" "publicip" {
  name                = format("pm-appsrv-%s-public-ip", var.environment)
  resource_group_name = azurerm_resource_group.appgw_rg.name
  location            = azurerm_resource_group.appgw_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_subnet" "appgw_subnet" {
  name                 = format("%s-%s", var.appgw_subnet_name, var.environment)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = var.vnet_name
  address_prefixes     = [data.azurerm_key_vault_secret.appgw-subnet-address-space.value]
}

resource "azurerm_application_gateway" "appgw" {
  # depends_on          = [module.web_app, azurerm_private_endpoint.inbound-endpt]
  enable_http2        = false
  location            = azurerm_resource_group.appgw_rg.location
  name                = "${var.appgw_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.appgw_rg.name

  tags = {
    kind        = "application gateway",
    environment = var.environment,
    standard    = "pci"
  }

  backend_address_pool {
    fqdns = [
      "pm-appsrv-logging-sit.azurewebsites.net",
      "pm-appsrv-wisp-sit.azurewebsites.net",
      "pm-appsrv-restapi-io-sit.azurewebsites.net",
      "pm-appsrv-restapi-sit.azurewebsites.net",
      "pm-appsrv-batch-sit.azurewebsites.net",
      "pm-appsrv-admin-panel-sit.azurewebsites.net",
      "pm-appsrv-rtd-sit.azurewebsites.net",
    ]
    name = "${var.backend_address_pool_name}-${var.environment}"
  }

  backend_http_settings {
    cookie_based_affinity               = "Disabled"
    host_name                           = var.backend_http_settings_host_name
    name                                = "pm-${var.environment}-http-setting"
    pick_host_name_from_backend_address = false
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

  probe {
    host                                      = var.backend_http_settings_host_name
    interval                                  = 30
    minimum_servers                           = 0
    name                                      = "pm-${var.environment}-http-setting"
    path                                      = "/"
    pick_host_name_from_backend_http_settings = false
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
    rewrite_rule_set_name      = "rewrite_location"
    rule_type                  = "Basic"
  }
  request_routing_rule {
    backend_address_pool_name  = "${var.backend_address_pool_name}-${var.environment}"
    backend_http_settings_name = "pm-${var.environment}-http-setting"
    http_listener_name         = "pm-${var.environment}-private-listener"
    name                       = "pm-${var.environment}-routing-private"
    rewrite_rule_set_name      = "rewrite_domain_private"
    rule_type                  = "Basic"
  }

  rewrite_rule_set {
    name = "rewrite_location"

    rewrite_rule {
      name          = "NewRewrite"
      rule_sequence = 100

      condition {
        ignore_case = true
        negate      = false
        pattern     = "(https?):\\/\\/.*azurewebsites\\.net(.*)$"
        variable    = "http_resp_Location"
      }

      response_header_configuration {
        header_name  = "Location"
        header_value = "{http_resp_Location_1}://pm-${var.environment}.westeurope.cloudapp.azure.com{http_resp_Location_2}"
      }
    }
  }
  rewrite_rule_set {
    name = "rewrite_domain_private"

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