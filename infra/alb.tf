resource "aws_lb" "app_alb" {
  name               = "${var.environment}-app-alb"
  load_balancer_type = "application"
  subnets            = var.alb_public_subnet_ids
  security_groups    = [aws_security_group.alb_sg.id]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.node_app_tg.arn
  }
}

# resource "aws_lb_listener" "https_listener" {
#   load_balancer_arn = aws_lb.app_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.node_app_tg.arn
#   }
# }
