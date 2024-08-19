output "aws_security_group_id" {
  value = aws_security_group.vpc-terraform-sg.id
}
output "subnet_public_1_id" {
  value = aws_subnet.vpc-terraform-public-1.id
}