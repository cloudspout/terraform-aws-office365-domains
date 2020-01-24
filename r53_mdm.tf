resource "aws_route53_record" "enterpriseregistration" {
  count = var.enable_mdm == true ? 1 : 0
  
  zone_id = var.zone.id
  name    = "enterpriseregistration.${var.zone.name}"
  type    = "CNAME"

  ttl     = 3600
  records = ["enterpriseregistration.windows.net"]
}


resource "aws_route53_record" "enterpriseenrollment" {
  count = var.enable_mdm == true ? 1 : 0

  zone_id = var.zone.id
  name    = "enterpriseenrollment.${var.zone.name}"
  type    = "CNAME"

  ttl     = 3600
  records = ["enterpriseenrollment.manage.microsoft.com"]
}