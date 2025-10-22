#########################
# Required Variables
#########################
variable "region" {
  description = "AWS region where this resource will be created."
  type        = string
  default     = null
}

variable "name" {
  description = "Name tag for the Client VPN endpoint."
  type        = string
  default     = null
}

variable "log_group_name" {
  description = "Name of the CloudWatch log group."
  type        = string
  default     = null
}

variable "log_stream_name" {
  description = "Name of the CloudWatch log stream."
  type        = string
  default     = null
}

variable "server_certificate_arn" {
  description = "The ARN of the ACM server certificate for the Client VPN endpoint."
  type        = string
}

variable "authentication_options" {
  description = "List of authentication options for the Client VPN endpoint."
  type = list(object({
    type                           = string
    active_directory_id            = optional(string)
    root_certificate_chain_arn     = optional(string)
    saml_provider_arn              = optional(string)
    self_service_saml_provider_arn = optional(string)
  }))
}

variable "connection_log_options" {
  description = "Configuration block for connection logging."
  type = object({
    enabled               = bool
    cloudwatch_log_group  = optional(string)
    cloudwatch_log_stream = optional(string)
  })
  default = {
    enabled = true
  }
}

variable "vpc_id" {
  description = "The ID of the VPC to associate with the Client VPN endpoint."
  type        = string
  default     = null
}

variable "client_cidr_block" {
  description = "The IPv4 address range in CIDR notation to assign client IP addresses. Required unless traffic_ip_address_type is ipv6."
  type        = string
  default     = null
}

#########################
# Optional Variables
#########################

variable "description" {
  description = "Description for the Client VPN endpoint."
  type        = string
  default     = null
}

variable "disconnect_on_session_timeout" {
  description = "Whether to disconnect the client VPN session after the maximum session_timeout_hours is reached."
  type        = bool
  default     = false
}

variable "dns_servers" {
  description = "Custom DNS servers to use. Can specify up to two."
  type        = list(string)
  default     = []
}

variable "endpoint_ip_address_type" {
  description = "IP address type for the Client VPN endpoint. Valid values: ipv4, ipv6, dual-stack."
  type        = string
  default     = "ipv4"
}

variable "self_service_portal" {
  description = "Enable or disable the self-service portal. Valid values: enabled, disabled."
  type        = string
  default     = "disabled"
}

variable "session_timeout_hours" {
  description = "Maximum session duration in hours. Valid values: 8, 10, 12, 24."
  type        = number
  default     = 24
}

variable "split_tunnel" {
  description = "Whether split-tunnel is enabled."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Map of tags to assign to the Client VPN endpoint."
  type        = map(string)
  default     = {}
}

variable "traffic_ip_address_type" {
  description = "IP address type for traffic within the Client VPN tunnel. Valid values: ipv4, ipv6, dual-stack."
  type        = string
  default     = "ipv4"
}

variable "transport_protocol" {
  description = "Transport protocol for the VPN session. Valid values: udp, tcp."
  type        = string
  default     = "udp"
}

variable "vpn_port" {
  description = "Port number for the Client VPN endpoint. Valid values: 443, 1194."
  type        = number
  default     = 443
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the Client VPN endpoint."
  type        = list(string)
  default     = []
}

variable "client_connect_options" {
  description = "Client connect options for managing connection authorization for new client connections."
  type = object({
    enabled             = bool
    lambda_function_arn = optional(string)
  })
  default = {
    enabled             = false
    lambda_function_arn = null
  }
}

variable "client_login_banner_options" {
  description = "Client login banner options."
  type = object({
    enabled     = bool
    banner_text = optional(string)
  })
  default = {
    enabled     = false
    banner_text = null
  }
}

variable "client_route_enforcement_options" {
  description = "Options to enforce administrator-defined routes on connected clients"
  type = object({
    enforced = bool
  })
  default = {
    enforced = false
  }
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the Client VPN endpoint for high availability."
  type        = list(string)
}

variable "route_definitions" {
  description = "List of CIDRs to create VPN routes for."
  type = list(object({
    cidr        = string
    description = optional(string)
  }))
  default = []
}

variable "authorization_rules" {
  description = "List of authorization rules to apply to the Client VPN."
  type = list(object({
    cidr                 = string
    description          = optional(string)
    access_group_id      = optional(string)
    authorize_all_groups = optional(bool)
  }))
  default = []
}

variable "name_prefix" {
  description = "Prefix name for the CloudWatch log group."
  type        = string
  default     = null
}

variable "skip_destroy" {
  description = "Whether to destroy the log group when resource is destroyed."
  type        = bool
  default     = false
}

variable "log_group_class" {
  description = "Log class of the log group."
  type        = string
  default     = "STANDARD"
}

variable "retention_in_days" {
  description = "Number of days to retain log events in the log group."
  type        = number
  default     = 0
}

variable "kms_key_id" {
  description = "KMS key ARN to encrypt the logs."
  type        = string
  default     = null
}
