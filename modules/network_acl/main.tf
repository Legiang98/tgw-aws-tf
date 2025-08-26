resource "aws_network_acl" "this" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      protocol   = egress.protocol
      rule_no    = egress.rule_no
      action     = egress.action
      cidr_block = egress.cidr_block
      from_port  = egress.from_port
      to_port    = egress.to_port
      icmp_type  = egress.icmp_type
      icmp_code  = egress.icmp_code
    }
  }

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      protocol   = ingress.protocol
      rule_no    = ingress.rule_no
      action     = ingress.action
      cidr_block = ingress.cidr_block
      from_port  = ingress.from_port
      to_port    = ingress.to_port
      icmp_type  = ingress.icmp_type
      icmp_code  = ingress.icmp_code
    }
  }
}