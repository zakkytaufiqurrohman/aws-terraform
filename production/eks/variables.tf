
################################################################################
# Default Variables
################################################################################

variable "profile" {
  type    = string
  default = "default"
}

variable "main-region" {
  type    = string
  default = "ap-northeast-1"
}


################################################################################
# EKS Cluster Variables
################################################################################

variable "cluster_name" {
  type    = string
  default = "tf-cluster"
}

variable "vpc_id" {
  type = string
  default = "vpc-01a54063bbb2ed5ba"
}

variable "subnets" {
  type = list(any)
  default = ["subnet-09c731eedbcf8cd98","subnet-0b2a49c4cc2351c5b"]
}
# variable "rolearn" {
#   description = "Add admin role to the aws-auth configmap"
# }

################################################################################
# ALB Controller Variables
################################################################################

variable "env_name" {
  type    = string
  default = "dev"
}