resource "aws_ec2_client_vpn_endpoint" "this" {
  # Required attributes
  server_certificate_arn = var.server_certificate_arn
  region                 = var.region
  client_cidr_block      = var.traffic_ip_address_type == "ipv4" ? var.client_cidr_block : null
  vpc_id                 = var.vpc_id

  dynamic "authentication_options" {
    for_each = var.authentication_options
    content {
      type                           = authentication_options.value.type
      root_certificate_chain_arn     = try(authentication_options.value.root_certificate_chain_arn, null)
      active_directory_id            = try(authentication_options.value.active_directory_id, null)
      saml_provider_arn              = try(authentication_options.value.saml_provider_arn, null)
      self_service_saml_provider_arn = try(authentication_options.value.self_service_saml_provider_arn, null)
    }
  }

  dynamic "connection_log_options" {
    for_each = var.connection_log_options.enabled ? [var.connection_log_options] : []
    content {
      enabled               = connection_log_options.value.enabled
      cloudwatch_log_group  = connection_log_options.value.cloudwatch_log_group == null ? aws_cloudwatch_log_group.this[0].name : connection_log_options.value.cloudwatch_log_group
      cloudwatch_log_stream = connection_log_options.value.cloudwatch_log_stream == null ? var.log_stream_name : connection_log_options.value.cloudwatch_log_stream
    }
  }

  # Optional attributes
  description                   = var.description
  disconnect_on_session_timeout = var.disconnect_on_session_timeout
  dns_servers                   = length(var.dns_servers) > 0 ? var.dns_servers : null
  endpoint_ip_address_type      = var.endpoint_ip_address_type
  self_service_portal           = var.self_service_portal
  session_timeout_hours         = var.session_timeout_hours
  split_tunnel                  = var.split_tunnel
  tags                          = merge({ Name = var.name }, var.tags)
  traffic_ip_address_type       = var.traffic_ip_address_type
  transport_protocol            = var.transport_protocol
  vpn_port                      = var.vpn_port
  security_group_ids            = length(var.security_group_ids) > 0 ? var.security_group_ids : null

  dynamic "client_connect_options" {
    for_each = var.client_connect_options.enabled ? [var.client_connect_options] : []
    content {
      enabled             = client_connect_options.value.enabled
      lambda_function_arn = client_connect_options.value.lambda_function_arn
    }
  }

  dynamic "client_login_banner_options" {
    for_each = var.client_login_banner_options.enabled ? [var.client_login_banner_options] : []
    content {
      enabled     = client_login_banner_options.value.enabled
      banner_text = client_login_banner_options.value.banner_text
    }
  }

  dynamic "client_route_enforcement_options" {
    for_each = var.client_route_enforcement_options.enforced ? [var.client_route_enforcement_options] : []
    content {
      enforced = client_route_enforcement_options.value.enforced
    }
  }
}

resource "aws_ec2_client_vpn_network_association" "this" {
  for_each = toset(var.subnet_ids)

  region                 = var.region
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = each.value
}

resource "aws_ec2_client_vpn_route" "this" {
  for_each = { for idx, route in local.network_routes : idx => route }

  region                 = var.region
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  destination_cidr_block = each.value.cidr
  target_vpc_subnet_id   = each.value.subnet_id
  description            = each.value.description
}

resource "aws_ec2_client_vpn_authorization_rule" "this" {
  for_each = { for idx, rule in var.authorization_rules : idx => rule }

  region                 = var.region
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  target_network_cidr    = each.value.cidr
  description            = try(each.value.description, null)
  access_group_id        = contains(keys(each.value), "access_group_id") ? each.value.access_group_id : null
  authorize_all_groups   = contains(keys(each.value), "authorize_all_groups") ? each.value.authorize_all_groups : null
}
