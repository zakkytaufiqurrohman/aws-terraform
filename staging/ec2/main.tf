module "ec2-module-staging" {
    source = "../../modules/ec2"

    ami_name = "ami-0a0b7b240264a48d7"
    instance_type = "t2.micro"
  
}