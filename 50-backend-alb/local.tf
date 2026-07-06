locals {
  common_name = "${var.project}-${var.environment}"
  common_tags = {
    Project      = "${var.project}"
    Environment  = "${var.environment}"
    Name         = "${local.common_name}"
    "Managed by" = "Terraform"
  }
  subnet_ids       = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  backend_lb_sg_id = data.aws_ssm_parameter.lb_sg.value
  backend_lb_arn   = aws_lb.backend-lb.arn
  domain_name      = "${var.project}.online"
}