global_resource_tags = {
  project = "demo"
  env     = "demo"
  layer   = "computing"
}

ec2 = {
  instance_vpc_main = {
    name                        = "ec2-vpc-main"
    ami                         = "ami-0e001c9271cf7f3b9"
    instance_type               = "t2.micro"
    security_group              = "security-group-allow-ssh-https-icmp-vpc-main"
    subnet_id                   = "subnet-main-vpc-ec2"
    key_name                    = "EC2_giangle1"
    instance_profile_arn        = "ec2SSM-iamrole"
    associate_public_ip_address = false
    volume_type                 = "gp2"
    volumes_size                = 8
    encrypted                   = true
    kms_key_id                  = null

    ebs = []

    network_interface = []

    create = "5m"
    update = "5m"
    delete = "5m"

    tags = {
      Environment = "demo"
      Vpc         = "vpc-main"
    }
  },
  instance_inspection = {
    name                        = "ec2-inspection-demo"
    ami                         = "ami-0e001c9271cf7f3b9"
    instance_type               = "t2.micro"
    security_group              = "security-group-allow-ssh-https-icmp-vpc-inspection"
    subnet_id                   = "subnet-vpc-inspection-waf"
    key_name                    = "EC2_giangle1"
    instance_profile_arn        = "ec2SSM-iamrole"
    associate_public_ip_address = false
    volume_type                 = "gp2"
    volumes_size                = 8
    encrypted                   = true
    kms_key_id                  = null

    ebs = []

    network_interface = []

    create = "5m"
    update = "5m"
    delete = "5m"

    tags = {
      Environment = "demo"
      Vpc         = "vpc-egress"
    }
  },
  instance_egress = {
    name                        = "ec2-egress-demo"
    ami                         = "ami-0e001c9271cf7f3b9"
    instance_type               = "t2.micro"
    security_group              = "security-group-allow-ssh-https-icmp-vpc-egress"
    subnet_id                   = "subnet-vpc-egress-ec2"
    key_name                    = "EC2_giangle1"
    instance_profile_arn        = "ec2SSM-iamrole"
    associate_public_ip_address = false
    volume_type                 = "gp2"
    volumes_size                = 8
    encrypted                   = true
    kms_key_id                  = null

    ebs = []

    network_interface = []

    create = "5m"
    update = "5m"
    delete = "5m"

    tags = {
      Environment = "demo"
      Vpc         = "vpc-egress"
    }
  }
}
