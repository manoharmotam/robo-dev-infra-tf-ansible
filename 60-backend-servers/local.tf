locals {
  common_name = "${var.project}-${var.environment}"
  common_tags = {
    Project      = "${var.project}"
    Environment  = "${var.environment}"
    Name         = "${local.common_name}"
    "Managed by" = "Terraform"
  }
  ami_id         = data.aws_ami.ami_id.id
  instance_type  = var.instance_type
  catalogue_sg_id  = data.aws_ssm_parameter.catalogue_sg_id.value
  user_sg_id    = data.aws_ssm_parameter.user_sg_id.value
  cart_sg_id    = data.aws_ssm_parameter.cart_sg_id.value
  shipping_sg_id = data.aws_ssm_parameter.shipping_sg_id.value
  payment_sg_id = data.aws_ssm_parameter.payment_sg_id.value
  private_subnet_id      = split(",", data.aws_ssm_parameter.subnet_ids.value)[0]
  vpc_id = data.aws_ssm_parameter.vpc_id

  domain_name = "${var.project}.online"
}
