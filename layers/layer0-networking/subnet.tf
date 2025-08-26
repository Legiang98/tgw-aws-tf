

module "subnet" {
  source   = "../../modules/subnet"
  for_each = local.subnet

  vpc_id = lookup(module.vpc, each.value.vpc_name).vpc_id

  name                    = each.value.name
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  global_resource_tags    = var.global_resource_tags
  tags                    = each.value.tags
}