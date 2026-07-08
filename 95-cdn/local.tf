# locals {
#   common_name = "${var.project}-${var.environment}"
#   common_tags = {
#     Project      = "${var.project}"
#     Environment  = "${var.environment}"
#     Name         = "${local.common_name}"
#     "Managed by" = "Terraform"
#   }
#   domain_name = "${var.project}.online"

#   cachingDisabled = data.aws_cloudfront_cache_policy.cachePolicyDisabled.id
#   cachingOptimized = data.aws_cloudfront_cache_policy.cachePolicyOptimized.id
#   certificate_arn = data.aws_ssm_parameter.certificate_arn.value
# }
