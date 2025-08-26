resource "aws_eip" "nat_eip" {
  tags = {
    Name = var.eip_name
  }
}

resource "aws_nat_gateway" "this" {

  subnet_id         = var.subnet_id
  connectivity_type = var.connectivity_type
  allocation_id     = aws_eip.nat_eip.id
  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

