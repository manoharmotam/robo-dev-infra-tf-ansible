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
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.project}-${var.environment}.${local.domain_name}"
    
    viewer_protocol_policy = "https-only"
    min_ttl = 0
    max_ttl = 86400
    default_ttl = 3600
    cache_policy_id = local.cachingDisabled
    }

    ordered_cache_behavior {
      
    }
}