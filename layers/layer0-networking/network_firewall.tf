module "network_firewall" {
  source = "../../modules/network_firewall"

  for_each = var.network_firewall

  name                 = each.value.name
  firewall_policy_arn  = each.value.firewall_policy_arn
  vpc_id               = lookup(module.vpc, each.value.vpc).vpc_id
  subnet_ids           = lookup(module.subnet, each.value.subnets).id
  ip_address_type      = each.value.ip_address_type
  global_resource_tags = var.global_resource_tags
  tags                 = each.value.tags

}