variable "name" {

}

variable "ami" {}

variable "instance_type" {}

variable "security_groups" {
  type = list(string)
}

variable "subnet_id" {}

variable "key_name" {}

variable "iam_instance_profile" {}

variable "associate_public_ip_address" {}

variable "volume_type" {}

variable "volumes_size" {
  default = 8
}

variable "iops" {
  default = null
}

variable "encrypted" {
  type    = bool
  default = true
}

variable "kms_key_id" {
  default = null
}

variable "ebs" {}

variable "network_interface" {

}

variable "create" {

}

variable "update" {

}

variable "delete" {

}

variable "global_resource_tags" {

}

variable "tags" {

}