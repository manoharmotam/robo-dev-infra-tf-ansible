resource "aws_cloudfront_distribution" "main" {
    origin {
        domain_name = "${var.project}-${var.environment}.${local.domain_name}"
        origin_id = "${var.project}-${var.environment}.${local.domain_name}"
        
        custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols = ["TLSv1.2"]
        }
    }

    enabled = true
    is_ipv6_enabled = false
    comment = "Hello"

    aliases = ["${var.project}-cdn-${local.domain_name}"]

    default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.project}-${var.environment}.${local.domain_name}"
    
    viewer_protocol_policy = "https-only"
    min_ttl = 0
    max_ttl = 86400
    default_ttl = 3600
    cache_policy_id = local.cachingDisabled
    }

    ordered_cache_behavior {
        path_pattern = "*/media/"
        allowed_methods  = ["GET", "HEAD", "OPTIONS"]
        cached_methods   = ["GET", "HEAD", "OPTIONS"]
        target_origin_id = "${var.project}-${var.environment}.${local.domain_name}"
        
        viewer_protocol_policy = "https-only"
        min_ttl = 0
        max_ttl = 3153600
        default_ttl = 86400
        cache_policy_id = local.cachingOptimized
    }

    ordered_cache_behavior {
        path_pattern = "*/videos/"
        allowed_methods  = ["GET", "HEAD", "OPTIONS"]
        cached_methods   = ["GET", "HEAD", "OPTIONS"]
        target_origin_id = "${var.project}-${var.environment}.${local.domain_name}"
        
        viewer_protocol_policy = "https-only"
        min_ttl = 0
        max_ttl = 3153600
        default_ttl = 86400
        cache_policy_id = local.cachingOptimized
    }

    restrictions {
      geo_restriction {
        restriction_type = "none"

      }
    }

    viewer_certificate {
      acm_certificate_arn = local.certificate_arn
      ssl_support_method = "https-only"
    }

}

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name = "${var.project}-cdn.${local.domain_name}"
  type = "A"

  alias {
    name = aws_cloudfront_distribution.main.domain_name
    zone_id = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = true
  }

  allow_overwrite = true
}