locals {
  vpc            = zipmap(var.vpc[*].name, var.vpc)
  nat            = zipmap(var.nat[*].name, var.nat)
  igw            = zipmap(var.igw[*].name, var.igw)
  subnet         = zipmap(var.subnets[*].name, var.subnets)
  route_table    = zipmap(var.route_table[*].name, var.route_table)
  tgw            = zipmap(var.tgw[*].name, var.tgw)
  tgw_attachment = zipmap(var.tgw_attachment[*].name, var.tgw_attachment)
  security_group = zipmap(var.security_group[*].name, var.security_group)
  network_acl    = zipmap(var.network_acl[*].name, var.network_acl)
}