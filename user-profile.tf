module "vpn-profile" {
  source = "./profile-module"
  count = length(var.user_list)
  name = element(var.user_list, count.index)
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem = tls_self_signed_cert.ca.cert_pem
}


output "user_private_key" {
  description = "Private key for user"
  value       = module.vpn-profile.*.user1_client_private_key
}


output "user_cert" {
  description = "Private key for user"
  value       = module.vpn-profile.*.user1_client_cert
}


resource "local_file" "script" {
  filename = "${path.module}/myscript.sh"
  content = join("\n", ["#!/bin/bash","set -e","aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.default.id} --output json"])

}

data "external" "example" {
  program = ["/bin/bash", "${path.module}/myscript.sh"]
}

output "commandout" {
  value = data.external.example.result.ClientConfiguration
}

resource "local_file" "users" {
  count = length(var.user_list)
  filename = "${path.module}/certs/${element(var.user_list,count.index)}.ovpn"
  content = join("\n", [data.external.example.result.ClientConfiguration,"<cert>",element(module.vpn-profile.*.user1_client_cert, count.index),"</cert>", "<key>",element(module.vpn-profile.*.user1_client_private_key, count.index),"</key>"])

}

