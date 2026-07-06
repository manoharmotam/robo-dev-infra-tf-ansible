locals {
  common_name = "${var.project}-${var.environment}"
  common_tags = {
    Project      = "${var.project}"
    Environment  = "${var.environment}"
    Name         = "${local.common_name}"
    "Managed by" = "Terraform"
  }
  subnet_ids     = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  frontend_lb_sg_id = data.aws_ssm_parameter.lb_sg.value
  frontend_lb_arn = aws_lb.frontend-lb.arn
  domain_name = "${var.project}.online"
  certificate_arn = data.aws_ssm_parameter.certificate_arn.value
}