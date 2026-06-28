terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.48.0"
    }
    # http = {
    #     source = "hashicorp/http"
    #     version = "3.5.0"
    # }
  }
  backend "s3" {
    bucket = "manoharmotam-remote-state-dev"
    key = "vpc.tfstate"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}