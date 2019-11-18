output "instance_id" {
  value = "${aws_instance.SVR.*.id}"
}

output "instance_public_ip" {
  value = "${aws_instance.SVR.*.public_ip}"
}

output "instance_private_ip" {
  value = "${aws_instance.SVR.*.private_ip}"
}

output "root_block_device_id" {
  value = "${data.aws_ebs_volume.ebs_root_volume.*.volume_id}"
}
