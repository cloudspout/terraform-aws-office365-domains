resource "aws_route53_record" "autodiscover" {
  zone_id = var.zone.id
  name    = "autodiscover.${var.zone.name}"
  type    = "CNAME"

  ttl     = 3600
  records = ["autodiscover.outlook.com"]
}
resource "aws_route53_record" "lyncdiscover" {
  zone_id = var.zone.id
  name    = "lyncdiscover.${var.zone.name}"
  type    = "CNAME"

  ttl     = 3600
  records = ["webdir.online.lync.com"]
}
