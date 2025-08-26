module "network_acl" {
  source   = "../../modules/network_acl"
  for_each = local.network_acl

  vpc_id        = lookup(module.vpc, each.value.vpc).vpc_id
  subnet_ids    = each.value.subnet_ids
  egress_rules  = each.value.egress_rules
  ingress_rules = each.value.ingress_rules
}