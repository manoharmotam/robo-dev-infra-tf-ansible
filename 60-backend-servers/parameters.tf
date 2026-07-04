resource "aws_ssm_parameter" "mysql" {
    name = "/${var.project}/${var.environment}/mysql_password"
    type = "SecureString"
    value = var.mysql_password
    overwrite = true
}