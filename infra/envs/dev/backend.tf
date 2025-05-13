terraform {
  backend "s3" {
    bucket         = "node-app-infra-tfstate-dev"
    key            = "terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
