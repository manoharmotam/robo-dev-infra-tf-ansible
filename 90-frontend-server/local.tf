locals {
  common_name = "${var.project}-${var.environment}"
  common_tags = {
    Project      = "${var.project}"
    Environment  = "${var.environment}"
    Name         = "${local.common_name}"
    "Managed by" = "Terraform"
  }
  ami_id                  = data.aws_ami.ami_id.id
  instance_type           = var.instance_type
  frontend_sg_id         = data.aws_ssm_parameter.frontend_sg_id.value
  private_subnet_id       = split(",", data.aws_ssm_parameter.subnet_ids.value)[0]
  vpc_id                  = data.aws_ssm_parameter.vpc_id.value
  frontend_lb_listener_arn = data.aws_ssm_parameter.frontend_lb_listener_arn.value

  domain_name = "${var.project}.online"
}
