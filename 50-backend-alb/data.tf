data "aws_ssm_parameter" "lb_sg" {
    name = "/${var.project}/${var.environment}/backend_lb"
}