module "aws_ecr_repository_app" {
  source                  = "s3::https://s3-eu-central-1.amazonaws.com/terraform-modules-9d7e951c290ec5bbe6506e0ddb064808764bc636/terraform-modules.zip//ecr/v1"
  ecr_repository_name     = var.service_name
  ecr_replication_targets = var.ecr_replication_targets
  ecr_replication_origin  = var.ecr_replication_origin
  tags                    = var.tags
}
