module "vpc" {
  source      = "./Modules/Network/vpc"
  vpcs    = "${var.vpcs}"
  environment = "${var.environment}"
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
  nat_gw = "${var.nat_gateways}"
  }

module "igw" {
  source      = "./Modules/Network/igw"
  vpc_id = "${module.vpc.vpc_id[0]}"
}

module "instance" {
  source      = "./Modules/EC2/instances"
  instance_data = "${var.instances}"
  environment = "${var.environment}"
}

module "security_group" {
  source      = "./Modules/Network/security_group"
  sg_data = "${var.security_groups}"
  vpc_id      = "${module.vpc.vpc_id[0]}"
  environment = "${var.environment}"
  security_group_rule = "${var.security_group_rule}"
  security_group_id = "${module.security_group.security_group_id[1]}"
}