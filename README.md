# terraform-aws-client-vpn
Terraform module for provisioning an AWS Client VPN

## Usage

```hcl
module "client-vpn" {
  source  = "anishkumarait/client-vpn/aws"
  version = "x.x.x"
  # insert the 4 required variables here
}
```

## Examples

* [client-vpn](https://github.com/anishkumarait/terraform-aws-client-vpn/tree/main/examples/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_client_vpn_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authentication_options"></a> [authentication\_options](#input\_authentication\_options) | List of authentication options for the Client VPN endpoint. | <pre>list(object({<br/>    type                           = string<br/>    active_directory_id            = optional(string)<br/>    root_certificate_chain_arn     = optional(string)<br/>    saml_provider_arn              = optional(string)<br/>    self_service_saml_provider_arn = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_authorization_rules"></a> [authorization\_rules](#input\_authorization\_rules) | List of authorization rules to apply to the Client VPN. | <pre>list(object({<br/>    cidr                 = string<br/>    description          = optional(string)<br/>    access_group_id      = optional(string)<br/>    authorize_all_groups = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_client_cidr_block"></a> [client\_cidr\_block](#input\_client\_cidr\_block) | The IPv4 address range in CIDR notation to assign client IP addresses. Required unless traffic\_ip\_address\_type is ipv6. | `string` | `null` | no |
| <a name="input_client_connect_options"></a> [client\_connect\_options](#input\_client\_connect\_options) | Client connect options for managing connection authorization for new client connections. | <pre>object({<br/>    enabled             = bool<br/>    lambda_function_arn = optional(string)<br/>  })</pre> | <pre>{<br/>  "enabled": false,<br/>  "lambda_function_arn": null<br/>}</pre> | no |
| <a name="input_client_login_banner_options"></a> [client\_login\_banner\_options](#input\_client\_login\_banner\_options) | Client login banner options. | <pre>object({<br/>    enabled     = bool<br/>    banner_text = optional(string)<br/>  })</pre> | <pre>{<br/>  "banner_text": null,<br/>  "enabled": false<br/>}</pre> | no |
| <a name="input_client_route_enforcement_options"></a> [client\_route\_enforcement\_options](#input\_client\_route\_enforcement\_options) | Options to enforce administrator-defined routes on connected clients | <pre>object({<br/>    enforced = bool<br/>  })</pre> | <pre>{<br/>  "enforced": false<br/>}</pre> | no |
| <a name="input_connection_log_options"></a> [connection\_log\_options](#input\_connection\_log\_options) | Configuration block for connection logging. | <pre>object({<br/>    enabled               = bool<br/>    cloudwatch_log_group  = optional(string)<br/>    cloudwatch_log_stream = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description for the Client VPN endpoint. | `string` | `null` | no |
| <a name="input_disconnect_on_session_timeout"></a> [disconnect\_on\_session\_timeout](#input\_disconnect\_on\_session\_timeout) | Whether to disconnect the client VPN session after the maximum session\_timeout\_hours is reached. | `bool` | `false` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | Custom DNS servers to use. Can specify up to two. | `list(string)` | `[]` | no |
| <a name="input_endpoint_ip_address_type"></a> [endpoint\_ip\_address\_type](#input\_endpoint\_ip\_address\_type) | IP address type for the Client VPN endpoint. Valid values: ipv4, ipv6, dual-stack. | `string` | `"ipv4"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name tag for the Client VPN endpoint. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region where this resource will be created. | `string` | `null` | no |
| <a name="input_route_definitions"></a> [route\_definitions](#input\_route\_definitions) | List of CIDRs to create VPN routes for. | <pre>list(object({<br/>    cidr        = string<br/>    description = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs to associate with the Client VPN endpoint. | `list(string)` | `[]` | no |
| <a name="input_self_service_portal"></a> [self\_service\_portal](#input\_self\_service\_portal) | Enable or disable the self-service portal. Valid values: enabled, disabled. | `string` | `"disabled"` | no |
| <a name="input_server_certificate_arn"></a> [server\_certificate\_arn](#input\_server\_certificate\_arn) | The ARN of the ACM server certificate for the Client VPN endpoint. | `string` | n/a | yes |
| <a name="input_session_timeout_hours"></a> [session\_timeout\_hours](#input\_session\_timeout\_hours) | Maximum session duration in hours. Valid values: 8, 10, 12, 24. | `number` | `24` | no |
| <a name="input_split_tunnel"></a> [split\_tunnel](#input\_split\_tunnel) | Whether split-tunnel is enabled. | `bool` | `false` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs to associate with the Client VPN endpoint for high availability. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the Client VPN endpoint. | `map(string)` | `{}` | no |
| <a name="input_traffic_ip_address_type"></a> [traffic\_ip\_address\_type](#input\_traffic\_ip\_address\_type) | IP address type for traffic within the Client VPN tunnel. Valid values: ipv4, ipv6, dual-stack. | `string` | `"ipv4"` | no |
| <a name="input_transport_protocol"></a> [transport\_protocol](#input\_transport\_protocol) | Transport protocol for the VPN session. Valid values: udp, tcp. | `string` | `"udp"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to associate with the Client VPN endpoint. | `string` | `null` | no |
| <a name="input_vpn_port"></a> [vpn\_port](#input\_vpn\_port) | Port number for the Client VPN endpoint. Valid values: 443, 1194. | `number` | `443` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_vpn_endpoint_arn"></a> [client\_vpn\_endpoint\_arn](#output\_client\_vpn\_endpoint\_arn) | The ARN of the Client VPN endpoint. |
| <a name="output_client_vpn_endpoint_dns_name"></a> [client\_vpn\_endpoint\_dns\_name](#output\_client\_vpn\_endpoint\_dns\_name) | The DNS name to be used by clients when establishing their VPN session. |
| <a name="output_client_vpn_endpoint_id"></a> [client\_vpn\_endpoint\_id](#output\_client\_vpn\_endpoint\_id) | The ID of the Client VPN endpoint. |
| <a name="output_client_vpn_network_association_association_ids"></a> [client\_vpn\_network\_association\_association\_ids](#output\_client\_vpn\_network\_association\_association\_ids) | A map of subnet\_id to the association ID of the target network association. |
| <a name="output_client_vpn_network_association_ids"></a> [client\_vpn\_network\_association\_ids](#output\_client\_vpn\_network\_association\_ids) | A map of subnet\_id to the unique ID of the target network association. |
| <a name="output_client_vpn_network_association_vpc_ids"></a> [client\_vpn\_network\_association\_vpc\_ids](#output\_client\_vpn\_network\_association\_vpc\_ids) | A map of subnet\_id to the VPC ID in which the target subnet is located. |
| <a name="output_client_vpn_route_ids"></a> [client\_vpn\_route\_ids](#output\_client\_vpn\_route\_ids) | A map of route key to the ID of the Client VPN route. |
| <a name="output_client_vpn_route_origins"></a> [client\_vpn\_route\_origins](#output\_client\_vpn\_route\_origins) | A map of route key to the origin type of the Client VPN route. Typically 'add-route' for manually added routes. |
| <a name="output_client_vpn_route_types"></a> [client\_vpn\_route\_types](#output\_client\_vpn\_route\_types) | A map of route key to the route type of the Client VPN route. |
| <a name="output_client_vpn_self_service_portal_url"></a> [client\_vpn\_self\_service\_portal\_url](#output\_client\_vpn\_self\_service\_portal\_url) | The URL of the self-service portal for the Client VPN endpoint. |
<!-- END_TF_DOCS -->

## License

See LICENSE file for full details.

## Maintainers

* [Anish Kumar](https://github.com/anishkumarait)

## Pre-commit hooks

### Install dependencies

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs) required for `terraform_docs` hooks.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.

#### MacOS

```bash
brew install pre-commit terraform-docs tflint

brew tap git-chglog/git-chglog
brew install git-chglog
```