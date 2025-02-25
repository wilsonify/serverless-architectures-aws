provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">1.5.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.76.1"
    }
  }
}
