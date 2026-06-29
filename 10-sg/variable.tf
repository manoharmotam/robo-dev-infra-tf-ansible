variable "project" {
  type    = string
  default = "mrmotam"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "sg_names" {
    default = ["mongodb", "redis", "mysql", "rabbitmq",
                "catalogue", "user", "cart", "shipping", "payment",
                "backend_lb", "frontend", "frontend_lb", "bastion"
      ]
}

variable "sg_tags" {
  type = map(string)
  default = {}
}