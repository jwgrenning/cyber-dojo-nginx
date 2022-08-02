# Allow all traffic from load balancer to app service
# https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html
module "app_service_sg" {
  source              = "terraform-aws-modules/security-group/aws"
  version             = "4.8.0"
  name                = "${var.service_name}-service"
  description         = "ECS. Service. Cyber-dojo"
  vpc_id              = data.aws_ssm_parameter.vpc_id.value
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]
  egress_rules        = ["all-all"]
  tags                = var.tags
}
