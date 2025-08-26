module "ec2" {
  source = "../../modules/ec2"

  for_each = var.ec2

  name                        = each.value.name
  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  security_groups             = [lookup(local.security_group_ids, each.value.security_group).id]
  subnet_id                   = lookup(local.subnet_ids, each.value.subnet_id).id
  key_name                    = try(each.value.key_name, null)
  iam_instance_profile        = each.value.instance_profile_arn
  associate_public_ip_address = each.value.associate_public_ip_address

  #root_block_device
  volume_type  = each.value.volume_type
  volumes_size = each.value.volumes_size
  iops         = try(each.value.iops, null)
  encrypted    = each.value.encrypted
  kms_key_id   = each.value.kms_key_id

  # ebs_block_device
  ebs = each.value.ebs

  # network_interface
  network_interface = each.value.network_interface

  # timeout
  create = each.value.create
  update = each.value.update
  delete = each.value.delete

  global_resource_tags = var.global_resource_tags
  tags                 = each.value.tags
}