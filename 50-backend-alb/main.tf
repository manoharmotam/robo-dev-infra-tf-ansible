resource "aws_lb" "backend-lb" {
    name = "backend-alb"
    internal = true
    load_balancer_type = "application"
    security_groups = [local.backend_lb_sg_id]
    subnets = local.subnet_ids

    enable_deletion_protection = false

    tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-backend-lb"
        }
    )
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = local.backend_lb_arn
    port = "80"
    protocol = "HTTP"

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
    name = "*.backend-lb-${var.environment}.${local.domain_name}"
    type = "A"

    alias {
      name = aws_lb.backend-lb.dns_name
      zone_id = aws_lb.backend-lb.zone_id
      evaluate_target_health = true
    }

    allow_overwrite = true
}