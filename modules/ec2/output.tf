output "ec2-public-ip" {
  value = aws_instance.web.public_ip
}