variable "name" {

}

variable "cidr_block" {
  type = string
}

variable "enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "global_resource_tags" {
  type = map(string)
}
variable "tags" {
  type = map(string)
}


