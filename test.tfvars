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
        subnet = "public_subnet-1a"
        name = "Bastian_SVR"
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
        subnet = "private_subnet-1a"
        name = "Web_SVR_1"
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
        subnet = "private_subnet-1b"
        name = "Web_SVR_2"
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
        description = "Bastian SG - Allow ssh traffic"
    },
    {
        name = "Web SG"
        description = "Web SG - Allow SSH from Bastian and http https from outer network"
    }
]

security_group_rules = [
    #Bastian SG Rule (SSH)
    {
        type        = "ingress"
        from_port   = "22"
        to_port     = "22"
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    },
    #WebSVR SG Rule (http)
    {
        type        = "ingress"
        from_port   = "80"
        to_port     = "80"
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    },
    #WebSVR SG Rule (https)
    {
        type        = "ingress"
        from_port   = "443"
        to_port     = "443"
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
]    

additional_security_group_rules = [
    #WebSVR SG rule, (Access WebSVRs through BastianSVR from port 22[SSH])
    {
        type            = "ingress"
        from_port       = "22"
        to_port         = "22"
        protocol        = "tcp"
        source_security_group_id = "Bastian SG"
    }
]