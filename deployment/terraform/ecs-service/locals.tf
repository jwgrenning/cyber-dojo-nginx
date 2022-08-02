locals {
  private_subnets         = split(",", data.aws_ssm_parameter.vpc_private_subnets.value)
  vpc_private_cidr_blocks = split(",", data.aws_ssm_parameter.vpc_private_cidr_blocks.value)
}
