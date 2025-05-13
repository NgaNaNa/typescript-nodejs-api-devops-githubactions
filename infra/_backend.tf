terraform {
  backend "s3" {
    bucket         = "node-app-infra-tfstate-${var.envirnment}" #pulls in value from the var file
    key            = "terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
