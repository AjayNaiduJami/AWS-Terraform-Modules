resource "aws_instance" "SVR" {
  count = "${length(var.instance_data)}"
  ami                    = "${lookup(var.instance_data[count.index],"ami")}"
  instance_type          = "${lookup(var.instance_data[count.index],"instance_type")}"
  vpc_security_group_ids = "${lookup(var.instance_data[count.index],"security_group")}"
  subnet_id              = "${lookup(var.instance_data[count.index],"subnet")}"
  associate_public_ip_address = "${lookup(var.instance_data[count.index],"associate_public_ip_address")}"
  user_data = "${lookup(var.instance_data[count.index],"user_data")}"
  key_name = "Terraform"
  tags = {
    Name = "${lookup(var.instance_data[count.index],"name")}"
    Environment = "Te${var.environment}"
    Terraform = "True"
    }
}
