terraform {
  backend "s3" {
    bucket         = "node-app-eks-tfstate-${var.environment}"
    key            = "eks/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
