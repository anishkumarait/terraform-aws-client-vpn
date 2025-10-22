terraform {
  required_version = ">= 1.6.0"

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
  server_certificate_arn = "arn:aws:acm:us-east-1:123456789:certificate/8bd9c28f-2a4c-xxxxxx" # certificate ARN
  client_cidr_block      = "xxx.xxx.xxx.xxx/xx"                                               # CIDR range for client connection

  authentication_options = [
    {
      type              = "federated-authentication"
      saml_provider_arn = "arn:aws:iam::1234567890:saml-provider/client-vpn"
    }
  ]

  log_group_name  = "test"
  log_stream_name = "test"
  subnet_ids      = ["subnet-xxx", "subnet-xxx"]
  vpc_id          = "vpc-xxx"

  authorization_rules = [
    {
      cidr                 = "xxx.xxx.xxx.xxx/xx" # VPC CIDR where VPN is created
      description          = "Source VPC CIDR"
      authorize_all_groups = true
    },
    # Additional VPCs where traffic will be routes
    {
      cidr                 = "xxx.xxx.xxx.xxx/xx"
      description          = "Additional VPC CIDR"
      authorize_all_groups = true
    }
  ]

  route_definitions = [
    #  Additional VPCs where traffic will be routes
    {
      cidr        = "xxx.xxx.xxx.xxx/xx"
      description = "Additionl VPC CIDR"
    }
  ]

}
