# Outlook / Exchange Online autodiscover.
resource "aws_route53_record" "autodiscover" {
  zone_id = var.zone_id
  name    = "autodiscover.${var.domain_name}"
  type    = "CNAME"

  ttl     = var.ttl
  records = ["autodiscover.outlook.com"]
}
