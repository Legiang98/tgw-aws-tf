global_resource_tags = {
  project = "demo"
  env     = "demo"
}


vpc = [
  {
    name                 = "vpc-main"
    cidr_block           = "10.1.0.0/16"
    enable_dns_hostnames = true
    tags = {
      type = "main"
    }
  },
  {
    name                 = "vpc-inspection"
    cidr_block           = "10.2.0.0/16"
    enable_dns_hostnames = true
    tags = {
      type = "inspection"
    }
  },
  {
    name                 = "vpc-egress"
    cidr_block           = "10.3.0.0/16"
    enable_dns_hostnames = true
    tags = {
      type = "egress"
    }
  }
]

nat = [
  {
    name              = "nat-vpc-egress"
    subnet            = "subnet-vpc-egress-NAT"
    connectivity_type = "public"
    eip_name          = "nat-gw-eip"
    eip_domain        = "vpc"
    tags = {
      type = "NAT"
      vpc  = "egress"
    }
  }
]

igw = [
  {
    name     = "igw-vpc-egress"
    vpc_name = "vpc-egress"
    tags = {
      type = "demo"
      vpc  = "vpc-egress"
    }
  },
  {
    name     = "igw-vpc-inspection"
    vpc_name = "vpc-inspection"
    tags = {
      type = "demo"
      vpc  = "vpc-inspection"
    }
  }
]

subnets = [
  {
    name                    = "subnet-main-vpc-ec2"
    vpc_name                = "vpc-main"
    cidr_block              = "10.1.2.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
    tags                    = {}
  },
  {
    name                    = "subnet-vpc-main-tgw-attachment"
    vpc_name                = "vpc-main"
    cidr_block              = "10.1.1.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
    tags                    = {}
  },
  {
    name                    = "subnet-vpc-inspection-waf"
    vpc_name                = "vpc-inspection"
    cidr_block              = "10.2.4.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
    tags                    = {}
  },
  {
    name                    = "subnet-vpc-inspection-tgw-attachment"
    vpc_name                = "vpc-inspection"
    cidr_block              = "10.2.6.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
    tags                    = {}
  },
  {
    name                    = "subnet-vpc-egress-tgw-attachment"
    vpc_name                = "vpc-egress"
    cidr_block              = "10.3.2.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
    tags                    = {}
  },
  {
    name                    = "subnet-vpc-egress-NAT"
    vpc_name                = "vpc-egress"
    cidr_block              = "10.3.4.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
    tags                    = {}
  },
  {
    name                    = "subnet-vpc-egress-ec2"
    vpc_name                = "vpc-egress"
    cidr_block              = "10.3.6.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
    tags                    = {}
  },

]

route_table = [
  {
    create_rtb         = true
    name               = "rtb-subnet-main-vpc-ec2"
    vpc_name           = "vpc-main"
    subnet_association = "subnet-main-vpc-ec2"
    routes = [
      {
        destination        = "0.0.0.0/0"
        transit_gateway_id = "tgw-demo"
      }
    ]
    tags = {}
  },
  {
    create_rtb         = true
    name               = "rtb-subnet-vpc-inspection-waf"
    vpc_name           = "vpc-inspection"
    subnet_association = "subnet-vpc-inspection-waf"
    routes = [
      {
        destination        = "0.0.0.0/0"
        transit_gateway_id = "tgw-demo"
      }
    ]
    tags = {}
  },
  {
    create_rtb         = true
    name               = "rtb-subnet-vpc-egress-NAT"
    vpc_name           = "vpc-egress"
    subnet_association = "subnet-vpc-egress-NAT"
    routes = [
      {
        destination = "0.0.0.0/0"
        gateway_id  = "igw-vpc-egress"
      },
      {
        destination        = "10.1.0.0/16"
        transit_gateway_id = "tgw-demo"
      },
      {
        destination        = "10.2.0.0/16"
        transit_gateway_id = "tgw-demo"
      },

    ]
    tags = {}
  },
  {
    create_rtb         = true
    name               = "rtb-subnet-vpc-egress-ec2"
    vpc_name           = "vpc-egress"
    subnet_association = "subnet-vpc-egress-ec2"
    routes = [
      {
        destination    = "0.0.0.0/0"
        nat_gateway_id = "nat-vpc-egress"
      },
      {
        destination        = "10.2.0.0/16"
        transit_gateway_id = "tgw-demo"
      },
      {
        destination        = "10.1.0.0/16"
        transit_gateway_id = "tgw-demo"
      }
    ]
    tags = {}
  },
  {
    create_rtb         = true
    name               = "rtb-subnet-vpc-main-tgw-attachment"
    vpc_name           = "vpc-main"
    subnet_association = "subnet-vpc-main-tgw-attachment"
    routes = [
      {
        destination        = "0.0.0.0/0"
        transit_gateway_id = "tgw-demo"
      }
    ]
    tags = {}
  },
  {
    create_rtb         = true
    name               = "rtb-subnet-vpc-inspection-tgw-attachment"
    vpc_name           = "vpc-inspection"
    subnet_association = "subnet-vpc-inspection-tgw-attachment"
    routes = [
      {
        destination        = "0.0.0.0/0"
        transit_gateway_id = "tgw-demo"
      }
    ]
    tags = {}
  },
  {
    create_rtb         = true
    name               = "rtb-subnet-vpc-egress-tgw-attachment"
    vpc_name           = "vpc-egress"
    subnet_association = "subnet-vpc-egress-tgw-attachment"
    routes = [
      {
        destination    = "0.0.0.0/0"
        nat_gateway_id = "nat-vpc-egress"
      }
    ]
    tags = {}
  }


]

tgw = [
  {
    name = "tgw-demo"
    tags = {
      type = "demo"
    }
  }
]

tgw_attachment = [
  {
    name                                 = "tgw-attachment-vpc-main"
    tgw                                  = "tgw-demo"
    auto_association                     = false
    auto_propagation                     = false
    rtb_name                             = "rtb-tgw-attachment-vpc-main"
    subnet                               = "subnet-vpc-main-tgw-attachment"
    vpc                                  = "vpc-main"
    appliance_mode_support               = "disable"
    dns_support                          = "disable"
    create_static_route                  = true
    destination_cidr_block               = "0.0.0.0/0"
    route_transit_gateway_vpc_attachment = "tgw-attachment-vpc-inspection"
    attachment_to_propagate              = ["tgw-attachment-vpc-inspection"]
    tags = {
      type = "tgw_attachment"
      vpc  = "vpc-main"
    }
  },
  {
    name                                 = "tgw-attachment-vpc-inspection"
    tgw                                  = "tgw-demo"
    auto_association                     = false
    auto_propagation                     = false
    rtb_name                             = "rtb-tgw-attachment-vpc-inspection"
    subnet                               = "subnet-vpc-inspection-tgw-attachment"
    vpc                                  = "vpc-inspection"
    appliance_mode_support               = "enable"
    dns_support                          = "disable"
    create_static_route                  = true
    destination_cidr_block               = "0.0.0.0/0"
    route_transit_gateway_vpc_attachment = "tgw-attachment-vpc-egress"
    attachment_to_propagate              = ["tgw-attachment-vpc-main", "tgw-attachment-vpc-egress"]
    tags = {
      type = "tgw_attachment"
      vpc  = "vpc-inspection"
    }
  },
  {
    name                                 = "tgw-attachment-vpc-egress"
    tgw                                  = "tgw-demo"
    auto_association                     = false
    auto_propagation                     = false
    rtb_name                             = "rtb-tgw-attachment-vpc-egress"
    subnet                               = "subnet-vpc-egress-tgw-attachment"
    vpc                                  = "vpc-egress"
    appliance_mode_support               = "disable"
    dns_support                          = "disable"
    create_static_route                  = true
    destination_cidr_block               = "0.0.0.0/0"
    route_transit_gateway_vpc_attachment = "tgw-attachment-vpc-inspection"
    attachment_to_propagate              = ["tgw-attachment-vpc-inspection"]
    tags = {
      type = "tgw_attachment"
      vpc  = "vpc-egress"
    }
  }
]

security_group = [
  {
    name        = "security-group-allow-ssh-https-icmp-vpc-inspection"
    description = "sg for allowing ssh https and icmp"
    vpc         = "vpc-inspection"
    ingress_rules = [
      {
        description = "allow ssh inbound"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow HTTP traffic"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow HTTPS traffic"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "allow ICMP inbound"
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  {
    name        = "security-group-allow-ssh-https-icmp-vpc-egress"
    description = "sg for allowing ssh https and icmp"
    vpc         = "vpc-egress"
    ingress_rules = [
      {
        description = "allow ssh inbound"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow HTTP traffic"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow HTTPS traffic"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "allow ICMP inbound"
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  {
    name        = "security-group-allow-ssh-https-icmp-vpc-main"
    description = "sg for allowing ssh https and icmp"
    vpc         = "vpc-main"
    ingress_rules = [
      {
        description = "allow ssh inbound"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow HTTP traffic"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow HTTPS traffic"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "allow ICMP inbound"
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
      }

    ]
    egress_rules = [
      {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
]

network_acl = []

network_firewall = {
  network_firewall_vpc_inspection = {
    name                = "network firewall"
    firewall_policy_arn = ""
    vpc                 = "vpc-inspection"
    subnets             = "subnet-vpc-inspection-waf"
    ip_address_type     = "IPV4"
    tags = {
      type = "firewall"
    }
  }
}