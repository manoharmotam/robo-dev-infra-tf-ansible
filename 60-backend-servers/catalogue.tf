resource "aws_instance" "catalogue" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.ec2_tags, local.common_tags,
    {
      Name = "${local.common_name}-catalogue"
    }
  )
}

resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  connection {
    port     = 22
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
    ]
  }
}

#Stop the instance before taking AMI for image consistency
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state = "stopped"

  depends_on = [ aws_instance.catalogue ]
}

#Take AMI for the stopped instance
resource "aws_ami_from_instance" "catalogue" {
  name = "${local.common_name}-catalogue-${var.environment}-${var.app_version}-${aws_instance.catalogue.id}" #mrmotam-catalogue-dev-v3-instance-id
  source_instance_id = aws_instance.catalogue.id
  depends_on = [ aws_ec2_instance_state.catalogue ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name}-catalogue-${var.app_version}-${aws_instance.catalogue.id}"
    }
  )
}

resource "aws_launch_template" "catalogue" {
  name = "${local.common_name}-catalogue"

  image_id = aws_ami_from_instance.catalogue.id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.catalogue_sg_id]
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      local.common_tags, 
      {
        Name = "${local.common_name}-catalogue-${var.app_version}-${aws_instance.catalogue.id}"

      }
    )
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(
      local.common_tags, 
      {
        Name = "${local.common_name}-catalogue-${var.app_version}-${aws_instance.catalogue.id}"

      }
    )    
  }

    tags = merge(
    local.common_tags, 
    {
      Name = "${local.common_name}-catalogue-${var.app_version}-${aws_instance.catalogue.id}"

    }
  )
}


resource "aws_lb_target_group" "catalogue" {
  name = "${local.common_name}-catalogue"
  port = 8080
  protocol = "HTTP"
  vpc_id = local.vpc_id
  deregistration_delay = 30

  health_check {
    protocol = "HTTP"
    path = "/health"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
    port = 8080
    matcher = "200-299"
  }
}