resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  security_groups             = var.security_groups
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volumes_size
    iops        = var.iops
    encrypted   = var.encrypted
    kms_key_id  = var.kms_key_id

  }

  dynamic "ebs_block_device" {
    for_each = var.ebs
    content {
      device_name           = each.value.device_name
      snapshot_id           = each.value.snapshot_id
      volume_type           = each.value.volume_type
      volume_size           = each.value.volume_size
      iops                  = each.value.iops
      delete_on_termination = each.value.delete_on_termination
      encrypted             = each.value.encrypted
      kms_key_id            = each.value.kms_key_id

    }
  }

  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      device_index          = each.value.device_index
      network_interface_id  = each.value.network_interface_id
      delete_on_termination = each.value.delete_on_termination
    }

  }
  timeouts {
    create = var.create
    update = var.update
    delete = var.delete
  }
  tags = merge(
    var.global_resource_tags,
    var.tags,
    {
      Name = var.name
    }
  )
}

