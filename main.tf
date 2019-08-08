module "vpc" {
  source      = "./Modules/Network/vpc"
  vpcs    = "${var.vpcs}"
  environment = "${var.environment}"
}

module "igw" {
  source      = "./Modules/Network/igw"
  vpc_id = "${module.vpc.vpc_id[0]}"
}

module "subnets" {
  source      = "./Modules/Network/subnets"
  private_subnets   = "${var.private_subnets}"
  public_subnets    = "${var.public_subnets}"
  private_route_tables = "${var.private_subnet_route_tables}"
  public_route_tables  = "${var.public_subnet_route_tables}"
  vpc_id = "${module.vpc.vpc_id[0]}"
  igw = "${module.igw.igw_id}"
  environment = "${var.environment}"
  private_subnet = "Private"
  public_subnet = "Public"
  nat_gw_id = "${module.nat_gw.nat_gw_id}"
}

module "nat_gw" {
  source      = "./Modules/Network/nat_gw"
  public_subnets    = "${var.public_subnets}"
  nat_gw = "${var.nat_gateways}"
  subnet_association = "${module.subnets.public_subnet_id}"
  environment = "${var.environment}"
}


module "security_group" {
  source      = "./Modules/Network/security_group"
  sg_data = "${var.security_groups}"
  vpc_id      = "${module.vpc.vpc_id[0]}"
  environment = "${var.environment}"

  security_group_rule = "${var.security_group_rules}"
  security_group_id = [
    "${module.security_group.security_group_id[0]}",
    "${module.security_group.security_group_id[2]}",
    "${module.security_group.security_group_id[2]}"
  ]
#Web SVR security group rule, (Web servers can only be accessed via port 22 (SSH) from Bastian SVR)
  additional_security_group_id = "${module.security_group.security_group_id[1]}" #Web SG
  additional_security_group_rule = "${var.additional_security_group_rules}"
  source_security_group_id = [
    "${module.security_group.security_group_id[0]}",  #Bastian SG
    "${module.security_group.security_group_id[2]}",  #ELB SG
    "${module.security_group.security_group_id[2]}"   #ELB SG
  ]
}

module "instance" {
  source      = "./Modules/EC2/instances"
  instance_data = "${var.instances}"
  environment = "${var.environment}"
  file = "install_apache.sh"
  subnet = [
    "${module.subnets.public_subnet_id[0]}"
  ]
  security_group = [
    "${module.security_group.security_group_id[0]}"
  ]
}

module "elb" {
  source      = "./Modules/EC2/elb"
  elb_data = "${var.elbs}"
  elb_subnets = [
    "${module.subnets.public_subnet_id[0]}",
    "${module.subnets.public_subnet_id[1]}"
  ]
  elb_security_groups = ["${module.security_group.security_group_id[2]}"] #ELB SG
  elb_instances = [
  
  ]
  environment = "${var.environment}"
}

module "launch_configuration" {
  source      = "./Modules/EC2/launch_configuration"
  lc_data = "${var.launch_configurations}"
  environment = "${var.environment}"
  file = "install_apache.sh"
  lc_security_groups = "${module.security_group.security_group_id[1]}"

}

module "autoscaling_group" {
  source      = "./Modules/EC2/autoscaling_group"
  autoscaling_data = "${var.autoscaling_groups}"
  launch_configuration = "${module.launch_configuration.launch_configuration_id[0]}"
  load_balancers = [
    "${module.elb.elb_id[0]}"
    ]
  autoscaling_subnets = [
    "${module.subnets.private_subnet_id[0]}",
    "${module.subnets.private_subnet_id[1]}"
  ]
  environment = "${var.environment}"
}