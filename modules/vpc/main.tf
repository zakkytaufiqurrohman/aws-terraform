// state
/*
create vpc
create subnet
create internet gateway
create route table
create association route table with subnet 
create association route table with internet gateway
create security group
*/

resource "aws_vpc" "vpc-terraform" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
    
    tags = {
        Name = "${var.vpc_name}"
    }
}

resource "aws_subnet" "vpc-terraform-public-1" {
  vpc_id     = aws_vpc.vpc-terraform.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.availability_zone_1
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.vpc_name}-public-1"
  }
}

resource "aws_subnet" "vpc-terraform-public-2" {
  vpc_id     = aws_vpc.vpc-terraform.id
  availability_zone = var.availability_zone_2
  cidr_block = var.public_subnet_2_cidr
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.vpc_name}-public-2"
  }
}

resource "aws_subnet" "vpc-terraform-private-1" {
  vpc_id     = aws_vpc.vpc-terraform.id
  availability_zone = var.availability_zone_3
  cidr_block = var.private_subnet_1_cidr

  tags = {
    Name = "${var.vpc_name}-private-1"
  }
}

# internet gateway
resource "aws_internet_gateway" "vpc-terraform-gw" {
  vpc_id = aws_vpc.vpc-terraform.id

  tags = {
    Name = "${var.vpc_name}-gw"
  }
}

resource "aws_route_table" "vpc-terraform-rt" {
  vpc_id = aws_vpc.vpc-terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-terraform-gw.id
  }

  tags = {
    Name = "${var.vpc_name}-rt"
  }
}

# route table assosiate
resource "aws_route_table_association" "vpc-terraform-a" {
  subnet_id      = aws_subnet.vpc-terraform-public-1.id
  route_table_id = aws_route_table.vpc-terraform-rt.id
}
resource "aws_route_table_association" "vpc-terraform-b" {
  subnet_id      = aws_subnet.vpc-terraform-public-2.id
  route_table_id = aws_route_table.vpc-terraform-rt.id
}
# Security Group
resource "aws_security_group" "vpc-terraform-sg" {
  vpc_id = aws_vpc.vpc-terraform.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-sg"
  }
}

