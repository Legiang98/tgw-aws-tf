
resource "aws_networkfirewall_firewall" "example" {
  name                = var.name
  firewall_policy_arn = var.firewall_policy_arn
  vpc_id              = var.vpc_id
  subnet_mapping {
    subnet_id = var.subnet_ids
    ip_address_type = var.ip_address_type
  }

  tags = merge(
    var.global_resource_tags,
    var.tags,
    {
      Name = var.name
    }
  )
}

