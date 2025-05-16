variable "environment" {
  description = "Environment to deploy into"
  type        = string
}

variable "aws_region" {
  description = "AWS Region to deploy into"
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the ECS cluster will be created"
}

variable "app_public_subnet_ids" {
  type = list(string)
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "desired_capacity" {
  type    = number
  default = 1
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 2
}

variable "key_name" {
  type        = string
  default     = ""
  description = "Name of the key pair to use for SSH access to the EC2 instances."
}

variable "container_port" {
  type        = number
  default     = 3000
  description = "Listening port for the container"
}
