output "vpc" {
  value = module.vpc
}

output "subnet_ids" {
  value = module.subnet.id
}

output "security_group_ids" {
  value = module.security_group.id
}

output "tgw_attachment" {
  value = module.tgw_attachment.id
}

