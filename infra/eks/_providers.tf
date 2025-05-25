provider "aws" {
  region = var.aws_region
  # Optionally pick credentials/profile via CLI flags or ENV vars
}

# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#   }
# }

# resource "kubernetes_namespace" "node-app" {
#   metadata { name = "node-api" }
# }

