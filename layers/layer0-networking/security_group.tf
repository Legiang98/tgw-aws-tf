module "security_group" {
  source = "../../modules/secrutiy_group"

  for_each = local.security_group

  name                 = each.value.name
  description          = each.value.description
  vpc_id               = lookup(module.vpc, each.value.vpc).vpc_id
  ingress_rules        = each.value.ingress_rules
  egress_rules         = each.value.egress_rules
  global_resource_tags = var.global_resource_tags

} 