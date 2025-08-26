
module "route_table" {
  source   = "../../modules/route_table"
  for_each = local.route_table

  create_rtb = each.value.create_rtb

  ### route table
  vpc_id               = lookup(module.vpc, each.value.vpc_name).vpc_id
  name                 = each.value.name
  global_resource_tags = var.global_resource_tags
  tags                 = each.value.tags

  ### route table association 
  subnet_id = lookup(module.subnet, each.value.subnet_association).id
}

locals {
  flattened_routes = flatten([
    for rtb in var.route_table : [
      for route in rtb.routes : {
        route_table_name          = rtb.name
        destination               = route.destination
        transit_gateway_id        = try(lookup(module.tgw, route.transit_gateway_id).id, null)
        gateway_id                = try(lookup(module.igw, route.gateway_id).id, null)
        nat_gateway_id            = try(lookup(module.nat, route.nat_gateway_id).id, null)
        vpc_endpoint_id           = try(lookup(module.tgw, route.vpc_endpoint_id).id, null)
        vpc_peering_connection_id = try(lookup(module.tgw, route.vpc_peering_connection_id).id, null)
        network_interface_id      = try(lookup(module.tgw, route.network_interface_id).id, null)
      }
    ]
  ])
}

resource "aws_route" "this" {
  for_each = {
    for idx, route in local.flattened_routes : "${route.route_table_name}-${idx}" => route
  }
  route_table_id            = lookup(module.route_table, each.value.route_table_name).route_table_id
  destination_cidr_block    = each.value.destination
  transit_gateway_id        = each.value.transit_gateway_id
  gateway_id                = each.value.gateway_id
  nat_gateway_id            = each.value.nat_gateway_id
  vpc_endpoint_id           = each.value.vpc_endpoint_id
  vpc_peering_connection_id = each.value.vpc_peering_connection_id
  network_interface_id      = each.value.network_interface_id
}
