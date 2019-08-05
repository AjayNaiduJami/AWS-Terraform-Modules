resource "aws_security_group" "sg" {
  count = "${length(var.sg_data)}"
  name = "${lookup(var.sg_data[count.index],"name")}"
  vpc_id = "${var.vpc_id}"
  description = "${lookup(var.sg_data[count.index],"description")}"
  tags = {
    Name = "${lookup(var.sg_data[count.index],"name")}"
    Environment = "${var.environment}"
    Terraform = "True"
  }
}

resource "aws_security_group_rule" "sg_rule" {
  count = "${length(var.security_group_rule)}"
  type            = "${lookup(var.security_group_rule[count.index],"type")}"
  from_port       = "${lookup(var.security_group_rule[count.index],"from_port")}"
  to_port         = "${lookup(var.security_group_rule[count.index],"to_port")}"
  protocol        = "${lookup(var.security_group_rule[count.index],"protocol")}"
  cidr_blocks     = ["${lookup(var.security_group_rule[count.index],"cidr_blocks")}"]
  security_group_id = "${element(var.security_group_id,count.index)}"
}

resource "aws_security_group_rule" "ssh_sg_rule" {
  count = "${length(var.additional_security_group_rule)}"
  type            = "${lookup(var.additional_security_group_rule[count.index],"type")}"
  from_port       = "${lookup(var.additional_security_group_rule[count.index],"from_port")}"
  to_port         = "${lookup(var.additional_security_group_rule[count.index],"to_port")}"
  protocol        = "${lookup(var.additional_security_group_rule[count.index],"protocol")}"
  security_group_id = "${var.additional_security_group_id}"
  source_security_group_id = "${var.source_security_group_id}"
}