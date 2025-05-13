provider "aws" {
  region = var.aws_region
  # Optionally pick credentials/profile via CLI flags or ENV vars
}

variable "aws_region" {
  description = "AWS Region to deploy into"
  type        = string
  default     = "ap-southeast-2"
}
