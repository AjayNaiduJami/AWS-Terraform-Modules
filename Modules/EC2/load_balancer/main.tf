resource "aws_lb" "load_balancer" {
  count = "${length(var.lb_data)}"
  name               = "${lookup(var.lb_data[count.index],"name")}"
  internal           = false
  load_balancer_type = "${lookup(var.lb_data[count.index],"load_balancer_type")}"
  security_groups    = "${var.lb_security_groups}"
  subnets            = "${var.lb_subnets}"
  tags = {
    Name = "${lookup(var.lb_data[count.index],"name")}"
    Environment = "${var.environment}"
    Terraform = "True"
    }
}
