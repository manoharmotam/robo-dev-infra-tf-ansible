resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         = var.mongodb
  to_port           = var.mongodb
  protocol          = "tcp"
  source_security_group_id = local.catalogue_sg_id
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  type              = "ingress"
  from_port         = var.mongodb
  to_port           = var.mongodb
  protocol          = "tcp"
  source_security_group_id = local.user_sg_id
  security_group_id = local.mongodb_sg_id
}


resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.ssh
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "redis_user" {
  type              = "ingress"
  from_port         = var.redis
  to_port           = var.redis
  protocol          = "tcp"
  source_security_group_id = local.user_sg_id
  security_group_id = local.redis_sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  type              = "ingress"
  from_port         = var.redis
  to_port           = var.redis
  protocol          = "tcp"
  source_security_group_id = local.cart_sg_id
  security_group_id = local.redis_sg_id
}

resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.ssh
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.redis_sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  type              = "ingress"
  from_port         = var.mysql
  to_port           = var.mysql
  protocol          = "tcp"
  source_security_group_id = local.shipping_sg_id
  security_group_id = local.mysql_sg_id
}

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.ssh
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mysql_sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  type              = "ingress"
  from_port         = var.rabbitmq
  to_port           = var.rabbitmq
  protocol          = "tcp"
  source_security_group_id = local.payment_sg_id
  security_group_id = local.rabbitmq_sg_id
}

resource "aws_security_group_rule" "rabbitmq_bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.ssh
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.rabbitmq_sg_id
}

resource "aws_security_group_rule" "catalogue_backend_lb" {
  type              = "ingress"
  from_port         = var.backend
  to_port           = var.backend
  protocol          = "tcp"
  source_security_group_id = local.backend_lb_sg_id
  security_group_id = local.catalogue_sg_id
}

resource "aws_security_group_rule" "catalogue_bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.ssh
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.catalogue_sg_id
}

resource "aws_security_group_rule" "user_backend_lb" {
  type              = "ingress"
  from_port         = var.backend
  to_port           = var.backend
  protocol          = "tcp"
  source_security_group_id = local.backend_lb_sg_id
  security_group_id = local.user_sg_id
}


resource "aws_security_group_rule" "user_bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.ssh
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.user_sg_id
}

resource "aws_security_group_rule" "cart_backend_lb" {
  type              = "ingress"
  from_port         = var.backend
  to_port           = var.backend
  protocol          = "tcp"
  source_security_group_id = local.backend_lb_sg_id
  security_group_id = local.cart_sg_id
}

resource "aws_security_group_rule" "cart_bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.backend
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.cart_sg_id
}

resource "aws_security_group_rule" "shipping_backend_lb" {
  type              = "ingress"
  from_port         = var.backend
  to_port           = var.backend
  protocol          = "tcp"
  source_security_group_id = local.backend_lb_sg_id
  security_group_id = local.shipping_sg_id
}

resource "aws_security_group_rule" "shipping_bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.ssh
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.shipping_sg_id
}

resource "aws_security_group_rule" "payment_backend_lb" {
  type              = "ingress"
  from_port         = var.backend
  to_port           = var.backend
  protocol          = "tcp"
  source_security_group_id = local.backend_lb_sg_id
  security_group_id = local.payment_sg_id
}

resource "aws_security_group_rule" "payment_bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.ssh
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.payment_sg_id
}

resource "aws_security_group_rule" "frontend_frontend_lb" {
  type              = "ingress"
  from_port         = var.frontend
  to_port           = var.frontend
  protocol          = "tcp"
  source_security_group_id = local.frontend_lb_sg_id
  security_group_id = local.frontend_sg_id
}

resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = var.ssh
  to_port           = var.ssh
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.frontend_sg_id
}

resource "aws_security_group_rule" "backend_lb_frontend" {
  type              = "ingress"
  from_port         = var.frontend
  to_port           = var.frontend
  protocol          = "tcp"
  source_security_group_id = local.frontend_sg_id
  security_group_id = local.backend_lb_sg_id
}

resource "aws_security_group_rule" "backend_lb_bastion" {
  type              = "ingress"
  from_port         = var.frontend
  to_port           = var.frontend
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.backend_lb_sg_id
}

resource "aws_security_group_rule" "backend_lb_catalogue" {
  type              = "ingress"
  from_port         = var.frontend
  to_port           = var.frontend
  protocol          = "tcp"
  source_security_group_id = local.catalogue_sg_id
  security_group_id = local.backend_lb_sg_id
}

resource "aws_security_group_rule" "backend_lb_user" {
  type              = "ingress"
  from_port         = var.frontend
  to_port           = var.frontend
  protocol          = "tcp"
  source_security_group_id = local.user_sg_id
  security_group_id = local.backend_lb_sg_id
}

resource "aws_security_group_rule" "backend_lb_cart" {
  type              = "ingress"
  from_port         = var.frontend
  to_port           = var.frontend
  protocol          = "tcp"
  source_security_group_id = local.cart_sg_id
  security_group_id = local.backend_lb_sg_id
}

resource "aws_security_group_rule" "backend_lb_shipping" {
  type              = "ingress"
  from_port         = var.frontend
  to_port           = var.frontend
  protocol          = "tcp"
  source_security_group_id = local.shipping_sg_id
  security_group_id = local.backend_lb_sg_id
}

resource "aws_security_group_rule" "backend_lb_payment" {
  type              = "ingress"
  from_port         = var.frontend
  to_port           = var.frontend
  protocol          = "tcp"
  source_security_group_id = local.payment_sg_id
  security_group_id = local.backend_lb_sg_id
}

resource "aws_security_group_rule" "frontend_lb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"] 
  security_group_id = local.frontend_lb_sg_id
}

resource "aws_security_group_rule" "frontend_lb_http" {
  type              = "ingress"
  from_port         = var.frontend
  to_port           = var.frontend
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"] 
  security_group_id = local.frontend_lb_sg_id
}

resource "aws_security_group_rule" "bastion" {
  type = "ingress"
  from_port = var.ssh
  to_port = var.ssh
  protocol = "tcp"
  cidr_blocks = ["${chomp(data.http.get_ip.response_body)}/32"]
  security_group_id = local.bastion_sg_id
}
