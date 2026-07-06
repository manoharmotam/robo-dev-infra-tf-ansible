resource "aws_ssm_parameter" "frontend_lb_listener_arn" {
  name      = "/${var.project}/${var.environment}/frontend_lb_listener_arn"
  type      = "String"
  value     = aws_lb_listener.http.arn
  overwrite = true
}