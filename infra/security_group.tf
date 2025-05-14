resource "aws_security_group" "ecs_instance_sg" {
  name        = "${var.environment}-ecs-instance-sg"
  description = "ECS container instances security group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0 # all ports is zero to zero
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}
