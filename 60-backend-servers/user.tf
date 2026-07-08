resource "aws_instance" "user" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  vpc_security_group_ids = [local.user_sg_id]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.ec2_tags, local.common_tags,
    {
      Name = "${local.common_name}-user"
    }
  )
}

resource "terraform_data" "user" {
  triggers_replace = [
    aws_instance.user.id
  ]

  connection {
    port     = 22
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.user.private_ip
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh user ${var.environment} ${var.app_version}"
    ]
  }
}

#Stop the instance before taking AMI for image consistency
resource "aws_ec2_instance_state" "user" {
  instance_id = aws_instance.user.id
  state       = "stopped"

  depends_on = [terraform_data.user]
}

#Take AMI for the stopped instance
resource "aws_ami_from_instance" "user" {
  name               = "${local.common_name}-user-${var.environment}-${var.app_version}-${aws_instance.user.id}" #mrmotam-user-dev-v3-instance-id
  source_instance_id = aws_instance.user.id
  depends_on         = [aws_ec2_instance_state.user]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name}-user-${var.app_version}-${aws_instance.user.id}"
    }
  )
}

resource "aws_launch_template" "user" {
  name = "${local.common_name}-user"

  image_id               = aws_ami_from_instance.user.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.user_sg_id]
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name}-user-${var.app_version}-${aws_instance.user.id}"

      }
    )
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name}-user-${var.app_version}-${aws_instance.user.id}"

      }
    )
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name}-user-${var.app_version}-${aws_instance.user.id}"

    }
  )
}


resource "aws_lb_target_group" "user" {
  name                 = "${local.common_name}-user"
  port                 = 8080
  protocol             = "HTTP"
  vpc_id               = local.vpc_id
  deregistration_delay = 30

  health_check {
    protocol            = "HTTP"
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    port                = 8080
    matcher             = "200-299"
  }
}

resource "aws_autoscaling_group" "user" {
  name                      = "${local.common_name}-user"
  max_size                  = 10
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 120
  health_check_type         = "ELB"
  force_delete              = false

  launch_template {
    id      = aws_launch_template.user.id
    version = "$Latest"
  }

  vpc_zone_identifier = [local.private_subnet_id]

  target_group_arns = [aws_lb_target_group.user.arn]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  dynamic "tag" {
    for_each = merge(
      local.common_tags,
      {
        Name = "${local.common_name}-user"
      }
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_policy" "user" {
  autoscaling_group_name = aws_autoscaling_group.user.name
  name                   = "${local.common_name}-user"
  policy_type            = "TargetTrackingScaling"

  estimated_instance_warmup = 120
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
  }
}

resource "aws_lb_listener_rule" "user" {
  listener_arn = local.backend_lb_listener_arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.user.arn
  }

  condition {
    host_header {
      values = ["user.backend-lb-${var.environment}.${local.domain_name}"]
    }
  }
}

resource "terraform_data" "user_delete" {
  triggers_replace = [
    aws_instance.user.id
  ]

  depends_on = [ aws_autoscaling_policy.user ]

  provisioner "local-exec" {
    command = "aws ec2 terminate-instances  --instance-ids ${aws_instance.user.id}"
  }
}