variable "project" {
  default = "mrmotam"
}

variable "environment" {
  default = "dev"
}

variable "mongodb"{
    default = "27017"
}

variable "redis"{
    default = "6379"
}

variable "mysql"{
    default = "3306"
}

variable "rabbitmq" {
  default = "5672"
}

variable "backend" {
  default = "8080"
}

variable "frontend" {
  default = "80"
}

variable "ssh" {
  default = "22"
}