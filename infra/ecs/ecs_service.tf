resource "aws_ecs_service" "node_app_service" {
  name            = "${var.environment}-node-app-svc"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.node_app_task.arn
  desired_count   = var.desired_service_count
  # launch_type     = "EC2"
  depends_on = [aws_iam_role_policy_attachment.ecs_exec_managed]

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
    weight            = 1
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.node_app_tg.arn
    container_name   = var.node_app_container_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets         = var.app_public_subnet_ids # tasks get ENIs here
    security_groups = [aws_security_group.task_sg.id]
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 60
}
