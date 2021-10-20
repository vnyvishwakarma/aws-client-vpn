resource "tls_private_key" "user1" {
  algorithm = "RSA"
}

resource "tls_cert_request" "user1" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.user1.private_key_pem

  subject {
    common_name  = "${var.name}.vpn.client.user1"
    organization = var.organization_name
  }
}


resource "tls_locally_signed_cert" "user1" {
  cert_request_pem   = tls_cert_request.user1.cert_request_pem
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = var.ca_private_key_pem
  ca_cert_pem        = var.ca_cert_pem
  validity_period_hours = 87600

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}



output "user1_client_private_key" {
  value       = tls_private_key.user1.private_key_pem
  description = "vpn.client.key.user1"
}

output "user1_client_cert" {
  value       = tls_locally_signed_cert.user1.cert_pem
  description = "user1_certificate"
}



variable "ca_private_key_pem" {
  description = "ca_private_key_pem"
}


variable "ca_cert_pem" {
  description = "ca_cert_pem"
}
