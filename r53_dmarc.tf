# DMARC policy record (recommended by Microsoft alongside SPF and DKIM).
# Only created when `dmarc_record` is set.
resource "aws_route53_record" "dmarc" {
  count = var.dmarc_record != null ? 1 : 0

  zone_id = var.zone_id
  name    = "_dmarc.${var.domain_name}"
  type    = "TXT"

  ttl     = var.ttl
  records = [var.dmarc_record]
}
