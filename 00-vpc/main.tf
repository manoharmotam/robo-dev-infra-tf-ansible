module "vpc" {
  source = "git::https://github.com/manoharmotam/terraform-aws-vpc.git?ref=main"
  
  environment = var.environment
  vpc_cidr = "192.168.0.0/16"
  is_peering_needed = false
  public_subnet_cidr = ["192.168.1.0/24", "192.168.11.0/24"]
  private_subnet_cidr = ["192.168.2.0/24", "192.168.21.0/24"]
  database_subnet_cidr = ["192.168.3.0/24", "192.168.31.0/24"]
}
