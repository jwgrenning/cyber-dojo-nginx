data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_canonical_user_id" "current" {}

data "aws_ssm_parameter" "vpc_id" {
  name = "vpc_id"
}

data "aws_ssm_parameter" "alb_listner_arn" {
  name = "alb_listner_arn"
}

data "aws_ssm_parameter" "vpc_private_subnets" {
  name = "vpc_private_subnets"
}

data "aws_ssm_parameter" "vpc_private_cidr_blocks" {
  name = "vpc_private_cidr_blocks"
}

data "aws_ssm_parameter" "ecs_cluster" {
  name = "ecs_cluster"
}

data "aws_ssm_parameter" "ecs_capacity_provider" {
  name = "ecs_capacity_provider"
}

data "aws_ssm_parameter" "alb_dns_name" {
  name = "alb_dns_name"
}

data "aws_ssm_parameter" "alb_zone_id" {
  name = "alb_zone_id"
}

data "aws_ssm_parameter" "alb_sg_id" {
  name = "alb_sg_id"
}

data "aws_service_discovery_dns_namespace" "this" {
  name = "cyber-dojo.${data.aws_region.current.name}"
  type = "DNS_PRIVATE"
}
