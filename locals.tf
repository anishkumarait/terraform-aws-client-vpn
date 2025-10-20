locals {
  # Combine each subnet with each route CIDR for route creation
  network_routes = [
    for pair in setproduct(var.subnet_ids, var.route_definitions) : {
      subnet_id   = pair[0]
      cidr        = pair[1].cidr
      description = try(pair[1].description, null)
    }
  ]

  # Set of all routed CIDRs
  #   routed_cidrs = toset([for route in local.network_routes : route.cidr])

  #   # Filtered authorization rules: only include those not in routed CIDRs
  #   authorization_rules_filtered = [
  #     for rule in var.authorization_rules : {
  #       cidr                 = rule.cidr
  #       description          = try(rule.description, null)
  #       access_group_id      = try(rule.access_group_id, null)
  #       authorize_all_groups = try(rule.authorize_all_groups, false)
  #     } if !(contains(local.routed_cidrs, rule.cidr))
  #   ]
}
