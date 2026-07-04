resource "aws_route53_record" "catalogue" {
  zone_id = var.zone_id
  name    = "catalogue-${var.environment}.${local.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.catalogue.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "user" {
  zone_id = var.zone_id
  name    = "user-${var.environment}.${local.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.user.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "cart" {
  zone_id = var.zone_id
  name    = "cart-${var.environment}.${local.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.cart.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "shipping" {
  zone_id = var.zone_id
  name    = "shipping-${var.environment}.${local.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.shipping.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "payment" {
  zone_id = var.zone_id
  name    = "payment-${var.environment}.${local.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.payment.private_ip]
  allow_overwrite = true
}
