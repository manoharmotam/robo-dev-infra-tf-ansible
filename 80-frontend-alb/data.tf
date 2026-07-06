data "aws_ssm_parameter" "lb_sg" {
  name = "/${var.project}/${var.environment}/frontend_lb_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "certificate_arn" {
  name = "/${var.project}/${var.environment}/certificate_arn"
}