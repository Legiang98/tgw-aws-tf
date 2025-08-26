variable "transit_gateway_id" {}

variable "subnet_ids" {}

variable "vpc_id" {}

variable "appliance_mode_support" {
  type    = string
  default = "disable"
}

variable "dns_support" {
  type    = string
  default = "disable"
}



variable "global_resource_tags" {}

variable "tags" {}

variable "attachment_name" {}

variable "rtb_name" {}

variable "auto_association" {
  default = false
}

variable "auto_propagation" {
  default = false
}


# variable "create_static_route" {
#   type    = bool
#   default = false
# }

# variable "destination_cidr_block" {}

# variable "route_transit_gateway_vpc_attachment" {

# }