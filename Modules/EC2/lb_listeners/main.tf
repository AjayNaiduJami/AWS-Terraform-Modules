
resource "aws_lb_listener" "listener" {
  count = "${length(var.lb_listener_data)}"
  load_balancer_arn = "${element(var.load_balancer_arn,count.index)}"
  port              = "${lookup(var.lb_listener_data[count.index],"port")}"
  protocol          = "${lookup(var.lb_listener_data[count.index],"protocol")}"
  ssl_policy        = "${lookup(var.lb_listener_data[count.index],"ssl_policy")}"
  certificate_arn   = "${element(var.certificate_arn,count.index)}"

  default_action {
    type             = "${lookup(var.lb_listener_data[count.index],"type")}"
    target_group_arn = "${element(var.target_group_arn,count.index)}"
  }
}