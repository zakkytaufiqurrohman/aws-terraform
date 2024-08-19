terraform {
  backend "s3" {
    bucket = "zakky"
    key = "terraform-module/production"
    region = "ap-northeast-1"
    encrypt = true
  }
}