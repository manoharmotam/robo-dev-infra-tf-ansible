locals {
  mongodb_sg_id = data.aws_ssm_parameter.mongodb.value
  redis_sg_id = data.aws_ssm_parameter.redis.value
  mysql_sg_id = data.aws_ssm_parameter.mysql.value
  rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq.value
  catalogue_sg_id = data.aws_ssm_parameter.catalogue.value
  user_sg_id = data.aws_ssm_parameter.user.value
  cart_sg_id = data.aws_ssm_parameter.cart.value
  shipping_sg_id = data.aws_ssm_parameter.shipping.value
  payment_sg_id = data.aws_ssm_parameter.payment.value
  backend_lb_sg_id = data.aws_ssm_parameter.backend_lb.value
  frontend_sg_id = data.aws_ssm_parameter.frontend.value
  frontend_lb_sg_id = data.aws_ssm_parameter.frontend_lb.value
  bastion_sg_id = data.aws_ssm_parameter.bastion.value
}   