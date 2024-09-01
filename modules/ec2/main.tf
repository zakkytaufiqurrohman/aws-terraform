# get key pair lama 
data "aws_key_pair" "awszakky" {
  key_name = "awszakky" # ganti dengan keypair yang sudah ada
}
# if aws_type spot else
resource "aws_spot_instance_request" "web" {
  count = var.type_instance == "spot" ? 1 : 0
  ami              = var.ami_name
  instance_type    = var.instance_type
  key_name = data.aws_key_pair.awszakky.key_name # attach key pair to ec2
  subnet_id = var.subnet_id
  security_groups = var.vpc_security_group_ids

  tags = {
    Name = "spot-${var.instance_name}"
  }
}
resource "aws_instance" "web" {
  count = var.type_instance == "spot" ? 0 : 1

  ami           = var.ami_name
  instance_type = var.instance_type
  key_name = data.aws_key_pair.awszakky.key_name # attach key pair to ec2
  subnet_id = var.subnet_id
  security_groups = var.vpc_security_group_ids


  tags = {
    Name = var.instance_name
  }
}