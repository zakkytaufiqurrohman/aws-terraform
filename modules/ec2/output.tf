output "ec2-public-ip" {
  # value = aws_instance.web.public_ip
  value = var.type_instance == "spot" ? aws_spot_instance_request.web[0].public_ip : aws_instance.web[0].public_ip
}