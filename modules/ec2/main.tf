# get key pair lama 
data "aws_key_pair" "awszakky" {
  key_name = "awszakky" # ganti dengan keypair yang sudah ada
}
resource "aws_instance" "web" {
  ami           = var.ami_name
  instance_type = var.instance_type
  key_name = data.aws_key_pair.awszakky.key_name # attach key pair to ec2
  subnet_id = var.subnet_id
  security_groups = var.vpc_security_group_ids


  tags = {
    Name = "var.instance_name"
  }
}