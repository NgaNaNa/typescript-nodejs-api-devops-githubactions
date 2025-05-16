# The target group is used by the ALB to route traffic to the ECS tasks ENI.
resource "aws_lb_target_group" "node_app_tg" {
  name        = "${var.environment}-app-tg"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = var.node_app_health_check_path
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
