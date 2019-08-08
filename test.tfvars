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
    },
    {
        name = "ELB SG"
        description = "ELB SG - Allow http and https traffic"
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
    #ELB SG Rule (http)
    {
        type        = "ingress"
        from_port   = "80"
        to_port     = "80"
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    },
    #ELB SG Rule (https)
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
    },
    #WebSVR SG rule, (Access WebSVRs through ELB from port 80[http])
    {
        type            = "ingress"
        from_port       = "80"
        to_port         = "80"
        protocol        = "tcp"
        source_security_group_id = "ELB SG"
    },
    #WebSVR SG rule, (Access WebSVRs through ELB from port 443[https])
    {
        type            = "ingress"
        from_port       = "443"
        to_port         = "443"
        protocol        = "tcp"
        source_security_group_id = "ELB SG"
    }
]

elbs = [
    {
        name               = "websvr-elb"
        availability_zones = "region specific" #availability zones mention in separate section, refet to top
        subnets = "Public subnets of websvr" 
        security_groups = "sg-elb" 
        instances = "websvrs" #attach this ELB to Autoscalinggroup for adding instances
        #listener
        instance_port     = "80"
        instance_protocol = "http"
        lb_port           = "80"
        lb_protocol       = "http"
        #health_check
        healthy_threshold   = "2"
        unhealthy_threshold = "2"
        timeout             = "5"
        target              = "TCP:80"
        interval            = "10"
        tags = {
            Name = "websvr-elb"
            Domain  = "qa.techtales.com"
            Purpose = "Practice"
        }
    }
]

launch_configurations = [
    {
        name   = "WebSVR-Launch-Configuration"
        image_id      = "ami-009110a2bf8d7dd0a"
        instance_type = "t2.micro"
        associate_public_ip_address = "0"
        security_groups = "Web SG" #Web SVR SG
        tags = {
            Domain  = "qa.techtales.com"
            Purpose = "Practice"
        }

    }
]
autoscaling_groups = [
    {
        name                      = "WebSVR-AutoScaling"
        desired_capacity          = "2"
        vpc_zone_identifier       = "VPC private subnets" #subnets private
        max_size                  = "2"
        min_size                  = "2"
        load_balancers = "" #websvr lb can be atted to autoassign autoscaled instances to LB
        tags = {
            Domain  = "qa.techtales.com"
            Purpose = "Practice"
        }
    }
]