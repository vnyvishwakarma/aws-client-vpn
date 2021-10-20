resource "aws_ec2_client_vpn_endpoint" "default" {
  description            = "${var.name}-Client-VPN"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = var.cidr
  # dns_servers = 
  # split_tunnel = 
  split_tunnel = true
  transport_protocol = "tcp"
  dns_servers = [cidrhost(var.vpc_cidr_block, 2)]
  authentication_options {
    type                       = var.authentication_type
    root_certificate_chain_arn = var.authentication_type != "certificate-authentication" ? null : aws_acm_certificate.root.arn
    saml_provider_arn          = var.authentication_saml_provider_arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }

  tags = merge(
    var.tags,
    tomap({
      "Name"    = "${var.name}-Client-VPN",
      "EnvName" = var.name
    })
  )
}

resource "aws_ec2_client_vpn_network_association" "default" {
  count                  = length(var.subnet_ids)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  subnet_id              = element(var.subnet_ids, count.index)
  security_groups        = [aws_security_group.vpn_sg.id]
}

resource "aws_ec2_client_vpn_authorization_rule" "default" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  target_network_cidr    = var.vpc_cidr_block
  authorize_all_groups   = true
}
