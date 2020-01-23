resource "aws_route53_record" "sip" {
  zone_id = var.zone.id
  name    = "sip.${var.zone.name}"
  type    = "CNAME"

  ttl     = 3600
  records = ["sipdir.online.lync.com"]
}

resource "aws_route53_record" "sip_tls" {
  zone_id = var.zone.id
  name    = "_sip._tls.${var.zone.name}"
  type    = "SRV"

  ttl     = 3600
  records = ["100 1 443 sipdir.online.lync.com"]
}

resource "aws_route53_record" "sipfederationtls_tcp" {
  zone_id = var.zone.id
  name    = "_sipfederationtls._tcp.${var.zone.name}"
  type    = "SRV"

  ttl     = 3600
  records = ["100 1 5061 sipfed.online.lync.com"]
}
