

module "vpc" {
  source   = "../../modules/vpc "
  for_each = local.vpc

  cidr_block           = each.value.cidr_block
  enable_dns_hostnames = each.value.enable_dns_hostnames
  name                 = each.value.name
  global_resource_tags = var.global_resource_tags
  tags                 = each.value.tags
}


module "igw" {
  source   = "../../modules/igw"
  for_each = local.igw

  igw_name = each.value.name
  vpc_id   = lookup(module.vpc, each.value.vpc_name).vpc_id
  tags     = each.value.tags
}

module "nat" {
  source   = "../../modules/nat"
  for_each = local.nat

  name              = each.value.name
  connectivity_type = each.value.connectivity_type
  subnet_id         = lookup(module.subnet, each.value.subnet).id
  eip_name          = each.value.eip_name
  tags              = each.value.tags

}



