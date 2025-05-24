module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.environment}-eks"
  cluster_version = "1.29"

  vpc_id     = var.vpc_id
  subnet_ids = var.app_public_subnet_ids

  # This config maps to an Auto Scaling Group under the hood
  eks_managed_node_groups = {
    default = {
      instance_types = ["var.instance_type"]
      desired_size   = 1
      min_size       = 1
      max_size       = 2
    }
  }
}
