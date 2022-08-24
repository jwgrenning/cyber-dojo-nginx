variable "service_name" {
  type    = string
  default = "nginx"
}

variable "env" {
  type = string
}

variable "app_port" {
  type    = number
  default = 80
}

variable "cpu_limit" {
  type    = number
  default = 50
}

variable "mem_limit" {
  type = number
  #default = 96
  default = 512
}

variable "mem_reservation" {
  type    = number
  default = 64
}

variable "TAGGED_IMAGE" {
  type = string
}

# App variables
variable "app_env_vars" {
  type = map(any)
  default = {
    DEPLOY_TO_ECS = "true"
  }
}

variable "ecr_replication_targets" {
  type    = list(map(string))
  default = []
}

variable "ecr_replication_origin" {
  type    = string
  default = ""
}

variable "app_domain_name" {
  type = string
}
