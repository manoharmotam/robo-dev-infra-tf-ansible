locals {
  common_name = "${var.project}-${var.environment}"
  common_tags = {
    Project      = "mrmotam"
    Environment  = "dev"
    Name         = local.common_name
    "Managed By" = "terraform"
  }
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}