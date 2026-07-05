resource "aws_acm_certificate" "name" {
  domain_name = var.domain_name
  validation_method = "DNS"
}