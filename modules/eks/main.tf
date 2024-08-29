################################################################################
# EKS Cluster
################################################################################
module "eks" {
	source  = "terraform-aws-modules/eks/aws"
	version = "~> 19.0"

	cluster_name    = "tf-cluster"
	cluster_version = "1.30"

	cluster_endpoint_public_access = true

	create_kms_key              = false
	create_cloudwatch_log_group = false
	cluster_encryption_config   = {}

	cluster_addons = {
		coredns = {
			most_recent = true
		}
		kube-proxy = {
			most_recent = true
		}
		vpc-cni = {
			most_recent = true
		}
		aws-ebs-csi-driver = {
			most_recent = true
		}
	}

	vpc_id                   = var.vpc_id
	subnet_ids               = var.private_subnets
	control_plane_subnet_ids = var.private_subnets

	# EKS Managed Node Group(s)
	eks_managed_node_group_defaults = {
		instance_types = ["m5.xlarge", "m5.large", "t3.medium"]
		iam_role_additional_policies = {
			AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
		}
	}

	eks_managed_node_groups = {
		blue = {
			min_size     = 1
			max_size     = 2
			desired_size = 1
			capacity_type  = "SPOT"
			instance_types = var.instance_node_group_types

		}
		# green = {
		#   min_size     = 1
		#   max_size     = 10
		#   desired_size = 1

		#   instance_types = ["t3.large"]
		#   capacity_type  = "SPOT"
		# }
	}

	tags = {
		env       = "dev"
		terraform = "true"
	}
}
