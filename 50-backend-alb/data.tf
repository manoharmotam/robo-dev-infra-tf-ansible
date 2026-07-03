data "aws_ssm_parameter" "lb_sg" {
    name = "/${var.project}/${var.environment}/backend_lb_sg_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
    name= "/${var.project}/${var.environment}/private_subnet_ids"
}