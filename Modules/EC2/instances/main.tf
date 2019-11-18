resource "aws_instance" "SVR" {
  count = "${length(var.instance_data)}"
  ami                    = "${lookup(var.instance_data[count.index],"ami")}"
  instance_type          = "${lookup(var.instance_data[count.index],"instance_type")}"
  vpc_security_group_ids = ["${element(var.security_group,count.index)}"]
  subnet_id              = "${element(var.subnet,count.index)}"
  associate_public_ip_address = "${lookup(var.instance_data[count.index],"associate_public_ip_address")}"
  user_data = "${file(var.file)}"
  key_name = "${lookup(var.instance_data[count.index],"key_name")}"
  root_block_device {
    volume_type = "${lookup(var.instance_data[count.index],"root_volume_type")}"
    volume_size = "${lookup(var.instance_data[count.index],"root_volume_size")}"
    delete_on_termination = "${lookup(var.instance_data[count.index],"delete_on_termination")}"
  }
  tags = {
    Name = "${lookup(var.instance_data[count.index],"name")}"
    Environment = "${var.environment}"
    Project = "${lookup(var.instance_data[count.index],"project")}"
    Terraform = "True"
    }
}

data "aws_ebs_volume" "ebs_root_volume" {
  count = "${length(var.instance_data)}"

  filter {
    name   = "attachment.instance-id"
    values = ["${element(aws_instance.SVR.*.id,count.index)}"]
  }
  filter {
    name   = "attachment.device"
    values = ["/dev/sda1"]
  }
}

resource "aws_volume_attachment" "ebs_att" {
  count = "${length(var.instance_data)}"
  device_name = "${lookup(var.instance_data[count.index],"device_name")}"
  volume_id   = "${lookup(var.instance_data[count.index],"volume_id")}"
  instance_id = "${element(aws_instance.SVR.*.id,count.index)}"
}
