################################################################################
# VPC Module
################################################################################
################################################################################
# EKS Cluster Module
################################################################################

module "eks" {
  source = "../../modules/eks"

  main-region = var.main-region
  profile     = var.profile
  # rolearn     = var.rolearn
  instance_node_group_types = ["t2.medium"]

  vpc_id          = var.vpc_id
  private_subnets = var.subnets
}

module "aws_alb_controller" {
  source = "../../modules/aws-alb-controller"

  main-region  = var.main-region
  env_name     = var.env_name
  cluster_name = var.cluster_name

  vpc_id            = var.vpc_id
  oidc_provider_arn = module.eks.oidc_provider_arn
}
