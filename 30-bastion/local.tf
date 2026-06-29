locals {
  common_name = "${var.project}-${var.env}"
  common_tags = {
    Project = "${var.project}"
    Environment = "${var.environment}"
    Name = local.common_name
    "Managed by" = "Terraform"
   }
  ami_id = data.aws_ami.ami_id
  instance_type = t3.micro 
}
