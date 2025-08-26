resource "aws_ec2_transit_gateway" "this" {
  description = var.description
  tags = merge(
    var.global_resource_tags,
    var.tags,
    {
      Name : var.name
    }
  )
}