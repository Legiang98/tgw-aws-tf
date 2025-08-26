variable "name" {

}
variable "vpc_id" {

}
variable "availability_zone" {

}

variable "map_public_ip_on_launch" {
  type    = bool
  default = false
}

variable "cidr_block" {
  type = string
}

variable "global_resource_tags" {
  type = map(string)
}
variable "tags" {
  type = map(string)
}


