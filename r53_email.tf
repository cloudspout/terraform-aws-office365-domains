resource "aws_route53_record" "ns" {
  allow_overwrite = true
  name            = var.zone.name
  ttl             = 172800
  type            = "NS"
  zone_id         = var.zone.zone_id

  records = var.zone.name_servers
}

resource "aws_route53_record" "mx" {
  zone_id = var.zone.id
  name    = var.zone.name
  type    = "MX"

  ttl     = 3600
  records = [var.mx_record]
}

resource "aws_route53_record" "txt" {
  zone_id = var.zone.id
  name    = var.zone.name
  type    = "TXT"

  ttl     = 3600
  records = var.domain_ownership_verification_code != "MS=ms XXXXXXXX" ? concat(var.txt_record, [var.domain_ownership_verification_code]) : var.txt_record
}

resource "aws_route53_record" "dkim1" {
  zone_id = var.zone.id
  name    = "selector1._domainkey.${var.zone.name}"
  type    = "CNAME"

  ttl     = 3600
  records = [var.domainkeys[0]]
}

resource "aws_route53_record" "dkim2" {
  zone_id = var.zone.id
  name    = "selector2._domainkey.${var.zone.name}"
  type    = "CNAME"

  ttl     = 3600
  records = [var.domainkeys[1]]
}
