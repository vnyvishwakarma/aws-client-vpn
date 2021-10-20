
resource "aws_security_group" "vpn_sg" {
name = "vpn_sg_${var.name}"
vpc_id = var.vpc_id
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
from_port = 443
    to_port = 443
    protocol = "tcp"
  }
// Terraform outbond rule
  egress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
}