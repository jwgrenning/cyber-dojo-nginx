resource "aws_lb_listener_certificate" "this" {
  for_each        = var.app_domain_names_list
  certificate_arn = aws_acm_certificate.public[each.key].arn
  listener_arn    = data.aws_ssm_parameter.alb_listner_arn.value
}

resource "aws_acm_certificate" "public" {
  for_each          = var.app_domain_names_list
  domain_name       = each.key
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
