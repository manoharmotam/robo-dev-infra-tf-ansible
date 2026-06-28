variable "project" {
  type    = string
  default = "mrmotam"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "sg_names" {
    default = ["mongodb", "redis", "mysql", "rabbitmq"]
}

variable "sg_tags" {
  type = map(string)
  default = {}
}