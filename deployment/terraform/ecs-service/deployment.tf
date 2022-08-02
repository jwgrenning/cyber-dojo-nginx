resource "aws_ecs_service" "this" {
  name                   = var.service_name
  cluster                = data.aws_ssm_parameter.ecs_cluster.value
  task_definition        = aws_ecs_task_definition.this.arn
  enable_execute_command = var.enable_execute_command
  desired_count          = var.desired_count
  force_new_deployment   = var.ecs_force_new_deployment
  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.service_name
    container_port   = var.app_port
  }
  capacity_provider_strategy {
    capacity_provider = data.aws_ssm_parameter.ecs_capacity_provider.value
    weight            = 100
  }
  network_configuration {
    subnets          = local.private_subnets
    security_groups  = [module.app_service_sg.security_group_id]
    assign_public_ip = false
  }
  propagate_tags = "SERVICE"
}

resource "aws_ecs_task_definition" "this" {
  family = var.service_name
  container_definitions = jsonencode([
    {
      name              = var.service_name
      image             = var.TAGGED_IMAGE
      cpu               = var.cpu_limit
      memory            = var.mem_limit
      memoryReservation = var.mem_reservation
      essential         = true
      portMappings = [
        {
          containerPort = var.app_port
        }
      ],
      mountPoints = local.mount_points
      environment = var.app_env_vars
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-region        = data.aws_region.current.name,
          awslogs-group         = aws_cloudwatch_log_group.this.name,
          awslogs-stream-prefix = format("/%s", var.service_name)
        }
      }
    }
  ])

  dynamic "volume" {
    for_each = var.volumes
    content {
      name = volume.value["name"]
      host_path = volume.value["host_path"]
    }
  }

  task_role_arn            = aws_iam_role.task.arn
  execution_role_arn       = aws_iam_role.exec.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
}

locals {
  mount_points = [for volume in var.volumes :  {"sourceVolume"  = "${volume.name}", "containerPath" = "${volume.containerPath}"}]
}
