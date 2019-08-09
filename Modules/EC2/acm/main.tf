resource "aws_acm_certificate" "acm" {
  private_key = "${file(var.priv_key)}"
  certificate_body = "${file(var.cert_body)}"
  certificate_chain = "${file(var.cert_chain)}"
  tags = {
    Name = "${var.acm_name}"
    Environment = "${var.environment}"
    Terraform = "True"
    }
}
