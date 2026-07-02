variable "project" {
  default = "mrmotam"
}

variable "environment" {
  default = "dev"
}

variable "instance_type" {
  default = "t3.micro"
}
variable "ec2_tags" {
  default = {}
}

variable "mysql_password" {
  type = string
}