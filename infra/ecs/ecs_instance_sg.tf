resource "aws_security_group" "ecs_instance_sg" {
  name        = "${var.environment}-ecs-instance-sg"
  description = "ECS container instances"
  vpc_id      = var.vpc_id

  # ALB to ECS instances on container port 3000
  ingress {
    description = "Traffic from ALB"
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    security_groups = [
      aws_security_group.alb_sg.id # only traffic coming in from ALB SG is allowed
    ]
  }

  # Outbound - from instances to Internet
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
