resource "aws_ssm_parameter" "certificate_arn" {
    value = aws_acm_certificate.main.arn
    name = "/${var.project}/${var.environment}/certificate_arn"
    type = "String"
    overwrite = true
}