module "ecs-service" {
  source                  = "./ecs-service"
  service_name            = var.service_name
  TAGGED_IMAGE            = var.TAGGED_IMAGE
  enable_execute_command  = "true"
  app_port                = var.app_port
  cpu_limit               = var.cpu_limit
  mem_reservation         = var.mem_reservation
  mem_limit               = var.mem_limit
  app_env_vars            = local.app_env_vars
  app_domain_names_list   = var.app_domain_names_list
  ecr_replication_targets = var.ecr_replication_targets
  ecr_replication_origin  = var.ecr_replication_origin
  tags                    = module.tags.result
}
