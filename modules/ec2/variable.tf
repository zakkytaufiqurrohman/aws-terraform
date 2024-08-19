variable "ami_name" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "subnet_id" {
  type = string
  description = "subner id"
}

variable "vpc_security_group_ids" {
  type = list(string)
  description = "list of security group"
}

variable "instance_name" {
  type = string
}

# variable "region" {
#     type = string
# #   default = "ap-northeast-1" 
# }