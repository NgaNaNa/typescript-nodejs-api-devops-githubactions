output "cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "instance_sg_id" {
  value = aws_security_group.ecs_instance_sg.id
}

output "capacity_provider_name" {
  value = aws_ecs_capacity_provider.ecs_capacity_provider.name
}

output "asg_arn" {
  value = aws_autoscaling_group.ecs_asg.arn
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "service_name" {
  value = aws_ecs_service.node_app_service.name
}
