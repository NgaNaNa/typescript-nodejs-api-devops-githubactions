resource "aws_ecs_task_definition" "node_app_task" {
  family             = "${var.environment}-node-app-task"
  network_mode       = "awsvpc"
  cpu                = "256"
  memory             = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "node-app"
      image = var.docker_image
      portMappings = [{
        containerPort = var.container_port
        protocol      = "tcp"
      }]
      essential = true
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:${var.container_port}${var.node_app_health_check_path} || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 10
      }
    }
  ])
}
