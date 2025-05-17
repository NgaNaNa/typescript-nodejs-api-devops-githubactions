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

variable "alb_public_subnet_ids" {
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

variable "node_app_health_check_path" {
  type        = string
  default     = "/ping"
  description = "Health check path for the target group"
}

# Public docker image for the application
variable "docker_image" {
  type    = string
  default = "nrampling/demo-node-app:1.0.0"
}

variable "desired_service_count" {
  type    = number
  default = 1
}

variable "node_app_container_name" {
  type    = string
  default = "node-app"
}
