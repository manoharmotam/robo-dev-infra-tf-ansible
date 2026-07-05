locals {
    common_tags = {
    Project      = "${var.project}"
    Environment  = "${var.environment}"
    "Managed by" = "Terraform"
  }
}