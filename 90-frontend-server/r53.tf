# resource "aws_route53_record" "frontend" {
#   zone_id         = var.zone_id
#   name            = "${var.project}-${var.environment}.${local.domain_name}"
#   type            = "A"
#   ttl             = 1
#   records         = [aws_instance.frontend.private_ip]
#   allow_overwrite = true
# }