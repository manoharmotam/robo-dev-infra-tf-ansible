resource "aws_lb" "frontend-lb" {
    name = "frontend-alb"
    internal = true
    load_balancer_type = "application"
    security_groups = [local.frontend_lb_sg_id]
    subnets = local.subnet_ids

    enable_deletion_protection = false

    tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-frontend-lb"
        }
    )
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = local.frontend_lb_arn
    port = "443"
    protocol = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = local.certificate_arn

    default_action {
      type = "fixed-response"

      fixed_response {
        content_type = "text/html"
        message_body = "<h1>Welcome! This page is created by terraform</h1>"
        status_code = "200"
      }
    }
}

resource "aws_route53_record" "www" {
    zone_id = var.zone_id
    name = "${var.project}-${var.environment}.${local.domain_name}"
    type = "A"

    alias {
      name = aws_lb.frontend-lb.dns_name
      zone_id = aws_lb.frontend-lb.zone_id
      evaluate_target_health = true
    }

    allow_overwrite = true
}