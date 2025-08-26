
resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  transit_gateway_id                              = var.transit_gateway_id
  subnet_ids                                      = var.subnet_ids
  vpc_id                                          = var.vpc_id
  appliance_mode_support                          = var.appliance_mode_support
  dns_support                                     = var.dns_support
  transit_gateway_default_route_table_association = var.auto_association
  transit_gateway_default_route_table_propagation = var.auto_propagation
  tags = merge(
    var.global_resource_tags,
    var.tags,
    {
      Name : var.attachment_name
    }
  )
}

resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = var.transit_gateway_id

  tags = merge(
    var.global_resource_tags,
    var.tags,
    {
      Name : var.rtb_name
    }
  )

}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}


# 1. Tao cert gắn vào elb và tạo CName trỏ đến elb
# 2. End user gọi đến internal elb
# 3. App nằm dưới elb - micro services, API gateway quản lý API trong app -> API gateway hoạt động với elb như nào
# 4. Pulic API trong API private thông qua 1 elb phía trên. (public elb -> internal API gw -> internal elb)
# 5. API gatway (resource method, state): connect micro service trong hệ thống, gắn domain cho các micro service khác nhau. Method trong API gw (gán VPC intergaration đến domain của microservices)
# -> luồng traffic sẽ như nào nếu gọi đến domain và uri api_gw.check 
# 6. Tìm hiểu về alb và nlb (listener, rules). Có bao nhiêu cách gắn rules cho từng thằng 
# redis 
# tao mot cache, tang replication instance (replication instance tang, scale thap) -> RDS proxy
# app -> db : van de la connection pool qua lớn, db nghẽn, timeout response -> cache (elastic cache)
# connection pool quota không đủ -> replication instance

# k8s db: RDS managed

