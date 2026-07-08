# data "aws_ssm_parameter" "certificate_arn" {
#   name = "/${var.project}/${var.environment}/certificate_arn"
# }

# data "aws_cloudfront_cache_policy" "cachePolicyDisabled" {
#   name = "Managed-CachingDisabled"
# }

# data "aws_cloudfront_cache_policy" "cachePolicyOptimized" {
#   name = "Managed-CachingOptimized"
# }