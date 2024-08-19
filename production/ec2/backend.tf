# untuk s3

# terraform {
#   backend "s3" {
#     bucket = "zakky"
#     key = "terraform-module"
#     region = "ap-northeast-1"
#     encrypt = true
#   }
# }
# pakai lokal
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}