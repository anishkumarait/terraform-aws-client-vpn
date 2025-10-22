locals {
  # Combine each subnet with each route CIDR for route creation
  network_routes = [
    for pair in setproduct(var.subnet_ids, var.route_definitions) : {
      subnet_id   = pair[0]
      cidr        = pair[1].cidr
      description = try(pair[1].description, null)
    }
  ]
}
