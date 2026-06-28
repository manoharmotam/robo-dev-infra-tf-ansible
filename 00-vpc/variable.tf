variable "project" {
  type    = string
  default = "mrmotam"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "public_subnet_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "private_subnet_cidr" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "database_subnet_cidr" {
  type    = list(string)
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "database_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "rt_tags" {
  type    = map(string)
  default = {}
}

variable "eip_tags" {
  type    = map(string)
  default = {}
}

variable "ngw_tags" {
  type    = map(string)
  default = {}
}

variable "is_peering_needed" {
  type    = bool
  default = false
}

variable "vpc_peering_tags" {
  type    = map(string)
  default = {}
}