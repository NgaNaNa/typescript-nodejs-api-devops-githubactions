resource "aws_security_group" "task_sg" {
  name        = "${var.environment}-task-sg"
  description = "securing each task ENIs created by ECS"
  vpc_id      = var.vpc_id

  ingress {
    description     = "ALB to tasks"
    protocol        = "tcp"
    from_port       = var.container_port
    to_port         = var.container_port
    security_groups = [aws_security_group.alb_sg.id] # only ALB allowed in
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# The task security group is used by the ECS service to create the ENIs for each tasks.
