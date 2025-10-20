terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "client_vpn" {
  source                 = "../"
  name                   = "test-vpn"
  server_certificate_arn = "arn:aws:acm:us-east-1:1234567890:certificate/xxxxxxxxxx" # certificate ARN
  client_cidr_block      = "xxx.xxx.xxx.xxx/xx"                                      # CIDR range for client connection

  authentication_options = [
    {
      type              = "federated-authentication"
      saml_provider_arn = "arn:aws:iam::1234567890:saml-provider/Client-VPN"
    }
  ]

  connection_log_options = {
    enabled               = true
    cloudwatch_log_group  = "test"
    cloudwatch_log_stream = "test"
  }

  subnet_ids = ["subnet-xxx", "subnet-xxx"]
  vpc_id     = "vpc-xxx"

  authorization_rules = [
    {
      cidr                 = "xxx.xxx.xxx.xxx/xx"
      description          = "VPC CIDR"
      authorize_all_groups = true
    }
  ]
}
