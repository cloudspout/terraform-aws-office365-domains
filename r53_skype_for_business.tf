# Legacy Skype for Business Online records.
#
# Skype for Business Online was retired on 2021-07-31 and Microsoft Teams does
# not require these records. They are only created when
# `enable_skype_for_business` is set to `true` for tenants still running
# Skype for Business Online.

resource "aws_route53_record" "lyncdiscover" {
  count = var.enable_skype_for_business ? 1 : 0

  zone_id = var.zone_id
  name    = "lyncdiscover.${var.domain_name}"
  type    = "CNAME"

  ttl     = var.ttl
  records = ["webdir.online.lync.com"]
}

resource "aws_route53_record" "sip" {
  count = var.enable_skype_for_business ? 1 : 0

  zone_id = var.zone_id
  name    = "sip.${var.domain_name}"
  type    = "CNAME"

  ttl     = var.ttl
  records = ["sipdir.online.lync.com"]
}

resource "aws_route53_record" "sip_tls" {
  count = var.enable_skype_for_business ? 1 : 0

  zone_id = var.zone_id
  name    = "_sip._tls.${var.domain_name}"
  type    = "SRV"

  ttl     = var.ttl
  records = ["100 1 443 sipdir.online.lync.com"]
}

resource "aws_route53_record" "sipfederationtls_tcp" {
  count = var.enable_skype_for_business ? 1 : 0

  zone_id = var.zone_id
  name    = "_sipfederationtls._tcp.${var.domain_name}"
  type    = "SRV"

  ttl     = var.ttl
  records = ["100 1 5061 sipfed.online.lync.com"]
}
