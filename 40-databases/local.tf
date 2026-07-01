locals {
  common_name = "${var.project}-${var.environment}"
  common_tags = {
    Project      = "${var.project}"
    Environment  = "${var.environment}"
    Name         = "${local.common_name}"
    "Managed by" = "Terraform"
  }
  ami_id               = data.aws_ami.ami_id.id
  instance_type        = var.instance_type
  mongodb_sg_id        = data.aws_ssm_parameter.mongodb_sg_id.value
  redis_sg_id          = data.aws_ssm_parameter.redis_sg_id.value
  mysql_sg_id          = data.aws_ssm_parameter.mysql_sg_id.value
  rabbitmq_sg_id       = data.aws_ssm_parameter.rabbitmq_sg_id.value
  subnet_id            = split(",", data.aws_ssm_parameter.subnet_ids.value)[0]
  policy_arn           = data.aws_iam_policy.iam_policy.arn
  iam_instance_profile = aws_iam_instance_profile.bastion.role
}
