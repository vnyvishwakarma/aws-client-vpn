/*
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
*/


# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}

# aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id cvpn-endpoint-0ecaefea6a5b7d8b7 --output text
#https://smartshift.com/guide-setting-up-an-aws-vpc-client-vpn/
#https://aws.amazon.com/premiumsupport/knowledge-center/client-vpn-configure-with-aws-cli/
# https://timeular.com/blog/creating-an-aws-client-vpn-with-terraform/

# https://github.com/tia-la/aws-clientvpn-hybridarchitecture-efs/blob/master/clientvpn_commands.txt

# https://www.youtube.com/watch?v=LYqLKH8VoYc