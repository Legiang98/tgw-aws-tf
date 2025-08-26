
module "tgw" {
  source   = "../../modules/tgw/tgw_main"
  for_each = local.tgw

  name                 = each.value.name
  global_resource_tags = var.global_resource_tags
  tags                 = each.value.tags
}

module "tgw_attachment" {
  source   = "../../modules/tgw/tgw_attachment"
  for_each = local.tgw_attachment

  attachment_name        = each.value.name
  transit_gateway_id     = lookup(module.tgw, each.value.tgw).id
  auto_association       = each.value.auto_association
  auto_propagation       = each.value.auto_propagation
  rtb_name               = each.value.rtb_name
  subnet_ids             = [lookup(module.subnet, each.value.subnet).id]
  vpc_id                 = lookup(module.vpc, each.value.vpc).vpc_id
  appliance_mode_support = each.value.appliance_mode_support
  dns_support            = each.value.dns_support
  tags                   = each.value.tags
  global_resource_tags   = var.global_resource_tags
}

resource "aws_ec2_transit_gateway_route" "static_route" {
  for_each = { for k, v in local.tgw_attachment : k => v if v.create_static_route }

  destination_cidr_block         = each.value.destination_cidr_block
  transit_gateway_attachment_id  = lookup(module.tgw_attachment, each.value.route_transit_gateway_vpc_attachment).id
  transit_gateway_route_table_id = lookup(module.tgw_attachment, each.value.name).transit_gateway_route_table_id

  # depends_on = [module.tgw_attachment]
}

locals {
  tgw_propagations = flatten([
    for attachment in var.tgw_attachment : [
      for attachment_id in attachment.attachment_to_propagate : {
        name                           = attachment.name
        transit_gateway_route_table_id = lookup(module.tgw_attachment, attachment.name).transit_gateway_route_table_id
        transit_gateway_attachment_id  = lookup(module.tgw_attachment, attachment_id).id
      }
    ]
  ])
}


resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  for_each = {
    for idx, propagation in local.tgw_propagations : "${idx}-${propagation.name}" => propagation
  }

  transit_gateway_route_table_id = each.value.transit_gateway_route_table_id
  transit_gateway_attachment_id  = each.value.transit_gateway_attachment_id
}



# Static route - shared vpc
# + 0.0.0.0/0 in rtb-attachment-egress -> target: attachment-inspection 
# + 0.0.0.0/0 in rtb-attachment-main -> target: attachment-inspection 
# + 0.0.0.0/0 in rtb-attachment-inspection -> target: attachment-egress (go to internet) * subnet-attachment-egress route to NAT gw
