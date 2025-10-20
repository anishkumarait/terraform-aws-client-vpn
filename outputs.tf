
output "client_vpn_endpoint_arn" {
  description = "The ARN of the Client VPN endpoint."
  value       = aws_ec2_client_vpn_endpoint.this.arn
}

output "client_vpn_endpoint_dns_name" {
  description = "The DNS name to be used by clients when establishing their VPN session."
  value       = aws_ec2_client_vpn_endpoint.this.dns_name
}

output "client_vpn_endpoint_id" {
  description = "The ID of the Client VPN endpoint."
  value       = aws_ec2_client_vpn_endpoint.this.id
}

output "client_vpn_self_service_portal_url" {
  description = "The URL of the self-service portal for the Client VPN endpoint."
  value       = aws_ec2_client_vpn_endpoint.this.self_service_portal_url
}

output "client_vpn_network_association_ids" {
  description = "A map of subnet_id to the unique ID of the target network association."
  value       = { for k, v in aws_ec2_client_vpn_network_association.this : k => v.id }
}

output "client_vpn_network_association_association_ids" {
  description = "A map of subnet_id to the association ID of the target network association."
  value       = { for k, v in aws_ec2_client_vpn_network_association.this : k => v.association_id }
}

output "client_vpn_network_association_vpc_ids" {
  description = "A map of subnet_id to the VPC ID in which the target subnet is located."
  value       = { for k, v in aws_ec2_client_vpn_network_association.this : k => v.vpc_id }
}

output "client_vpn_route_ids" {
  description = "A map of route key to the ID of the Client VPN route."
  value       = { for k, v in aws_ec2_client_vpn_route.this : k => v.id }
}

output "client_vpn_route_origins" {
  description = "A map of route key to the origin type of the Client VPN route. Typically 'add-route' for manually added routes."
  value       = { for k, v in aws_ec2_client_vpn_route.this : k => v.origin }
}

output "client_vpn_route_types" {
  description = "A map of route key to the route type of the Client VPN route."
  value       = { for k, v in aws_ec2_client_vpn_route.this : k => v.type }
}
