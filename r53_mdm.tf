resource "aws_route53_record" "enterpriseregistration" {
  zone_id = var.zone.id
  name    = "enterpriseregistration.${var.zone.name}"
  type    = "CNAME"

  ttl     = 3600
  records = ["enterpriseregistration.windows.net"]
}


resource "aws_route53_record" "enterpriseenrollment" {
  zone_id = var.zone.id
  name    = "enterpriseenrollment.${var.zone.name}"
  type    = "CNAME"

  ttl     = 3600
  records = ["enterpriseenrollment.manage.microsoft.com"]
}