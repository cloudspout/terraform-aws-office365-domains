resource "aws_route53_record" "root" {
  count = "${var.ip == "0.0.0.0" ? 0 : 1}"

  zone_id = var.zone.id
  name    = var.zone.name
  type    = "A"

  ttl     = 3600
  records = [var.ip]
}

resource "aws_route53_record" "www" {
  count = "${var.ip == "0.0.0.0" ? 0 : 1}"

  zone_id = var.zone.id
  name    = "www.${var.zone.name}"
  type    = "A"

  ttl     = 3600
  records = [var.ip]
}
