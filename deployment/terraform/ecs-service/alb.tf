# Create target groups to route traffic to the app
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html
resource "random_string" "string" {
  length  = 5
  upper   = false
  special = false
  numeric = false
}

resource "aws_lb_target_group" "this" {
  name_prefix = "${random_string.string.result}-"
  target_type = "ip"
  protocol    = "HTTP"
  port        = var.app_port
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  health_check {
    interval = 30
    timeout  = 10
    matcher  = "200"
    path     = "/ready"
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = merge({
    "service_name" = var.service_name
  }, var.tags)
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = data.aws_ssm_parameter.alb_listner_arn.value
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
  condition {
    host_header {
      values = var.app_domain_names_list
    }
  }
}
