# Exchange Online mail flow, SPF and DKIM records.

resource "aws_route53_record" "mx" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "MX"

  ttl     = var.ttl
  records = [var.mx_record]
}

# Apex TXT record: SPF plus (optionally) the Microsoft domain-ownership code.
resource "aws_route53_record" "txt" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "TXT"

  ttl = var.ttl
  records = var.domain_ownership_verification_code != null ? [
    var.spf_record,
    var.domain_ownership_verification_code,
  ] : [var.spf_record]
}

# DKIM: selector1._domainkey and selector2._domainkey CNAMEs.
resource "aws_route53_record" "dkim" {
  count = 2

  zone_id = var.zone_id
  name    = "selector${count.index + 1}._domainkey.${var.domain_name}"
  type    = "CNAME"

  ttl     = var.ttl
  records = [var.domainkeys[count.index]]
}
