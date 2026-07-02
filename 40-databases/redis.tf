resource "aws_instance" "redis" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id              = local.subnet_id

  tags = merge(
    var.ec2_tags,
    {
      Name = "${local.common_name}-redis"
    },
    local.common_tags
  )
}

resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  connection {
    port     = 22
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
    ]
  }
}