resource "aws_instance" "mysql" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id              = local.subnet_id
  iam_instance_profile = local.iam_instance_profile
  tags = merge(
    var.ec2_tags,
    {
      Name = "${local.common_name}-rabbitmq"
    },
    local.common_tags
  )
}

resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]

  connection {
    port     = 22
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}"
    ]
  }
}