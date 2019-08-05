variable "region" {
  type = "string"
}

variable "access_key" {
  type = "string"
}

variable "secret_key" {
  type = "string"
}

variable "environment" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "vpcs" {
  type = "list"
}

variable "private_subnets" {
  type = "list"
}

variable "public_subnets" {
  type = "list"
}

variable "nat_gateways" {
  type = "list"
}

variable "private_subnet_route_tables"  {
  type = "list"
  }

variable "public_subnet_route_tables"  {
  type = "list"
  }

variable "instances"  {
  type = "list"
  }

  variable "security_groups"  {
  type = "list"
  }

variable "security_group_rules" {
  type = "list"
}

variable "additional_security_group_rules" {
  type = "list"
}
