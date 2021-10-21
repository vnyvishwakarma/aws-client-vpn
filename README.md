# Introduction 

Provides an AWS Client VPN endpoint for OpenVPN clients. 

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc\_id | VPC ID to associate aws vpn clients | `string` | `null` | yes |
| subnet\_ids | Subnet ID to associate clients | `list(string)` | n/a | yes |
| vpc_cidr_block | VPC Network CIDR Block | `any` | n/a | yes |
| name | Name prefix for the resources of this stack | `any` | n/a | yes |
| cidr | Network CIDR to use for clients | `any` | n/a | yes |
| user_list | List of users for aws client vpn | `list(string)` | n/a | yes |
| aws_s3_bucket | s3 bucket name where certs needs to be uploaded | `string` | n/a | yes |
| sg_ports | outbound ports that needs to alow once vpn client is connected | `list(number)` | [22,3389,3306] | no

## Outputs

No output.

<!--- END_TF_DOCS --->

## Author

Module managed by CloudStudio Team
