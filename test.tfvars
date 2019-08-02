#For keys, refer keys.txt
access_key = ""
secret_key = ""

name = "qa.techtales.com"

environment = "QA"

region = "ap-south-1"

availability_zones = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
]

vpcs = [
    {
        name = "qa.techtales.com"
        cidr = "10.1.0.0/16"
        enable_dns_support = "1"
        enable_dns_hostnames = "1"
        tags = {
            Domain  = "qa.techtales.com"
            Purpose = "Practice"
        }
    }
]

nat_gateways = [
    {
        name = "public-1a.qa.techtales.com"
        tags = {
            Domain  = "qa.techtales.com"
            Purpose = "Practice"
            AvailabilityZone = "ap-south-1a"
        }
    },
    {
        name = "public-1b.qa.techtales.com"
        tags = {
            Domain  = "qa.techtales.com"
            Purpose = "Practice"
            AvailabilityZone = "ap-south-1b"
        }
    },
    {
        name = "public-1c.qa.techtales.com"
        tags = {
            Domain  = "qa.techtales.com"
            Purpose = "Practice"
            AvailabilityZone = "ap-south-1c"
        }
    }
]

private_subnets = [
    {
        name = "private-1a.qa.techtales.com"
        cidr = "10.1.100.0/24"
        availability_zone = "ap-south-1a"
        tags = {
            Domain     = "qa.techtales.com"
            Purpose    = "Practice"
            SubnetType = "Private"
        }
    },
    {
        name = "private-1b.qa.techtales.com"
        cidr = "10.1.101.0/24"
        availability_zone = "ap-south-1b"
        tags = {
            Domain     = "qa.techtales.com"
            Purpose    = "Practice"
            SubnetType = "Private"
        }
    }, 
    {
        name = "private-1c.qa.techtales.com"
        cidr = "10.1.102.0/24"
        availability_zone = "ap-south-1c"
        tags = {
            Domain     = "qa.techtales.com"
            Purpose    = "Practice"
            SubnetType = "Private"
        }
    }
]


public_subnets = [
    {
        name = "public-1a.qa.techtales.com"
        cidr = "10.1.1.0/24"
        availability_zone = "ap-south-1a"
        tags = {
            Domain     = "qa.techtales.com"
            Purpose    = "Practice"
            SubnetType = "Public"
        }
    },
    {
        name = "public-1b.qa.techtales.com"
        cidr = "10.1.2.0/24"
        availability_zone = "ap-south-1b"
        tags = {
            Domain     = "qa.techtales.com"
            Purpose    = "Practice"
            SubnetType = "Public"
        }
    },
    {
        name = "public-1c.qa.techtales.com"
        cidr = "10.1.3.0/24"
        availability_zone = "ap-south-1c"
        tags = {
            Domain     = "qa.techtales.com"
            Purpose    = "Practice"
            SubnetType = "Public"
        }
    }
    
]

private_subnet_route_tables = [
    {
        name = "private-1a-rt.qa.techtales.com"
        tags = {
            Domain     = "qa.techtales.com"
            Purpose    = "Practice"
            RouteTableType = "Private"
        }
    },
    {
        name = "private-1b-rt.qa.techtales.com"
        tags = {
            Domain     = "qa.techtales.com"
            Purpose    = "Practice"
            RouteTableType = "Private"
        }
    },
    {
        name = "private-1c-rt.qa.techtales.com"
        tags = {
            Domain     = "qa.techtales.com"
            Purpose    = "Practice"
            RouteTableType = "Private"
        }
    }
]

public_subnet_route_tables =  [
    {
        name = "public.qa.techtales.com"
        tags = {
            Domain     = "qa.techtales.com"
            Purpose    = "Practice"
            SubnetType = "Public"
        }
    }
]

instances = [
    {
        ami = "ami-009110a2bf8d7dd0a"
        instance_type = "t2.micro"
        associate_public_ip_address = "1"
        subnet = "${module.subnets.public_subnet_id[0]}"
        name = "Bastian SVR"
        user_data = ""
        tags = {
            Domain  = "qa.techtales.com"
            Purpose = "Practice"
            AvailabilityZone = "ap-south-1a"
        }
    },
    {
        ami = "ami-009110a2bf8d7dd0a"
        instance_type = "t2.micro"
        associate_public_ip_address = "0"
        subnet = "${module.subnets.private_subnet_id[0]}"
        name = "Web SVR 1"
        user_data = ""
        tags = {
            Domain  = "qa.techtales.com"
            Purpose = "Practice"
            AvailabilityZone = "ap-south-1a"
        }
    },
    {
        ami = "ami-009110a2bf8d7dd0a"
        instance_type = "t2.micro"
        associate_public_ip_address = "0"
        subnet = "${module.subnets.private_subnet_id[1]}"
        name = "Web SVR 2"
        security_group = ""
        user_data = ""
        tags = {
            Domain  = "qa.techtales.com"
            Purpose = "Practice"
            AvailabilityZone = "ap-south-1b"
        }
    }
]

security_groups = [
    {
        name = "Bastian SG"
        description = "Allow ssh traffic"
        ingress_from_port = 22
        ingress_to_port = 22
        ingress_protocol = "tcp"
        ingress_cidr_blocks = ["0.0.0.0/0"]
        egress_from_port = 0
        egress_to_port = 0
        egress_protocol = "-1"
        egress_cidr_blocks = ["0.0.0.0/0"]
    },
    {
        name = "Web SG"
        description = "Allow bastian http traffic"
        ingress_from_port = 80
        ingress_to_port = 80
        ingress_protocol = "tcp"
        egress_from_port = 0
        egress_to_port = 0
        egress_protocol = "-1"
        egress_cidr_blocks = ["0.0.0.0/0"]
    }
]

security_group_rule = [
    {
        type            = "ingress"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
    }
]