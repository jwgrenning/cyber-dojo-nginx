variable "ecr_replication_targets" {
  type    = list(map(string))
  default = []
}

variable "ecr_replication_origin" {
  type    = string
  default = ""
}

variable "app_domain_names_list" {
  type = set(string)
}

variable "service_name" {
  type = string
}

variable "app_port" {
  type = number
}

variable "cpu_limit" {
  type = number
}

variable "mem_limit" {
  type = number
}

variable "mem_reservation" {
  type = number
}

variable "logs_retention_in_days" {
  type    = number
  default = 14
}

variable "enable_execute_command" {
  type    = bool
  default = false
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "ecs_force_new_deployment" {
  type    = bool
  default = true
}

variable "TAGGED_IMAGE" {
  type = string
}

variable "volumes" {
  description = "A map of volumes to add to the task definition"
  type        = set(map(string))
  default     = []
}

# App variables
variable "app_env_vars" {
  type    = set(any)
  default = []
}

# App secrets
variable "app_secrets_names_list" {
  type        = set(string)
  description = "app secrets names"
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}