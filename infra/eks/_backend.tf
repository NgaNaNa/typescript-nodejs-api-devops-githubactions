terraform {
  backend "s3" {
    key            = "eks/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
