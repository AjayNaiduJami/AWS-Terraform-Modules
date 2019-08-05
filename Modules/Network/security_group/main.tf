resource "aws_security_group" "sg" {
    count = "${length(var.sg_data)}"
    name = "${lookup(var.sg_data[count.index],"name")}"
    vpc_id = "${var.vpc_id}"
    description = "${lookup(var.sg_data[count.index],"description")}"

  ingress {
    from_port = "${lookup(var.sg_data[count.index],"ingress_from_port")}"
    to_port = "${lookup(var.sg_data[count.index],"ingress_to_port")}"
    protocol = "${lookup(var.sg_data[count.index],"ingress_protocol")}"
    cidr_blocks = ["${lookup(var.sg_data[count.index],"ingress_cidr_blocks")}"]
  }
  egress {
    from_port = "${lookup(var.sg_data[count.index],"egress_from_port")}"
    to_port = "${lookup(var.sg_data[count.index],"egress_to_port")}"
    protocol = "${lookup(var.sg_data[count.index],"egress_protocol")}"
    cidr_blocks = ["${lookup(var.sg_data[count.index],"egress_cidr_blocks")}"]
  }
  tags = {
    Name = "${lookup(var.sg_data[count.index],"name")}"
    Environment = "${var.environment}"
    Terraform = "True"
  }
}

resource "aws_security_group_rule" "ssh" {
  count = "${length(var.security_group_rule)}"
  type            = "${lookup(var.security_group_rule[count.index],"type")}"
  from_port       = "${lookup(var.security_group_rule[count.index],"from_port")}"
  to_port         = "${lookup(var.security_group_rule[count.index],"to_port")}"
  protocol        = "${lookup(var.security_group_rule[count.index],"protocol")}"
  security_group_id = "${var.security_group_id}"
}