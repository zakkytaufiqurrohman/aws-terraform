module "vpc" {
    source = "../../modules/vpc"
    availability_zone_1 = "ap-northeast-1a"
    availability_zone_2 = "ap-northeast-1c"
    availability_zone_3 = "ap-northeast-1d"
    vpc_cidr = "10.0.0.0/16"
    public_subnet_1_cidr = "10.0.1.0/24"
    public_subnet_2_cidr = "10.0.2.0/24"
    private_subnet_1_cidr = "10.0.3.0/24"
    vpc_name = "vpc-by-terraform"

}

module "ec2-module" {
    source = "../../modules/ec2"
    instance_name = "web-server"
    subnet_id = module.vpc.subnet_public_1_id // jika sudah punya subnet ganti dengan id subnet yang sudah ada 
    vpc_security_group_ids = [module.vpc.aws_security_group_id] // jika sudah punya security group ganti gengan security group yang ada
    ami_name = "ami-0162fe8bfebb6ea16"
    instance_type = "t2.micro"
}

# output "ip-public" {
#   value = module.ec2-module.public_ip
# }