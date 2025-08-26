locals {
  create_rtb = var.create_rtb == null ? true : var.create_rtb
}

resource "aws_route_table" "this" {
  count = var.create_rtb ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(
    var.global_resource_tags,
    var.tags,
    {
      Name : var.name
    }
  )
}

resource "aws_route_table_association" "this" {

  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.this[0].id

}

# resource "aws_route" "this" {
#   route_table_id = aws_route_table.this[0].id
#   ### Destination
#   destination_cidr_block = var.destination_cidr_block
#   ### Target
#   transit_gateway_id        = var.transit_gateway_id
#   gateway_id                = var.gateway_id
#   nat_gateway_id            = var.nat_gateway_id
#   vpc_endpoint_id           = var.vpc_endpoint_id
#   vpc_peering_connection_id = var.vpc_peering_connection_id
#   network_interface_id      = var.network_interface_id
# }