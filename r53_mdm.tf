# Intune / Mobile Device Management (MDM) enrollment records.
resource "aws_route53_record" "enterpriseregistration" {
  count = var.enable_mdm ? 1 : 0

  zone_id = var.zone_id
  name    = "enterpriseregistration.${var.domain_name}"
  type    = "CNAME"

  ttl     = var.ttl
  records = ["enterpriseregistration.windows.net"]
}

resource "aws_route53_record" "enterpriseenrollment" {
  count = var.enable_mdm ? 1 : 0

  zone_id = var.zone_id
  name    = "enterpriseenrollment.${var.domain_name}"
  type    = "CNAME"

  ttl     = var.ttl
  records = ["enterpriseenrollment.manage.microsoft.com"]
}
