output "mx_fqdn" {
  description = "FQDN of the created MX record."
  value       = aws_route53_record.mx.fqdn
}

output "spf_txt_fqdn" {
  description = "FQDN of the apex TXT record carrying the SPF (and optional ownership) value."
  value       = aws_route53_record.txt.fqdn
}

output "dkim_fqdns" {
  description = "FQDNs of the two DKIM selector CNAME records."
  value       = [for r in aws_route53_record.dkim : r.fqdn]
}

output "autodiscover_fqdn" {
  description = "FQDN of the autodiscover CNAME record."
  value       = aws_route53_record.autodiscover.fqdn
}

output "dmarc_fqdn" {
  description = "FQDN of the DMARC TXT record, or null when not created."
  value       = one(aws_route53_record.dmarc[*].fqdn)
}

output "mdm_fqdns" {
  description = "FQDNs of the MDM enrollment CNAME records, empty when disabled."
  value = concat(
    aws_route53_record.enterpriseregistration[*].fqdn,
    aws_route53_record.enterpriseenrollment[*].fqdn,
  )
}

output "skype_for_business_fqdns" {
  description = "FQDNs of the legacy Skype for Business records, empty when disabled."
  value = concat(
    aws_route53_record.lyncdiscover[*].fqdn,
    aws_route53_record.sip[*].fqdn,
    aws_route53_record.sip_tls[*].fqdn,
    aws_route53_record.sipfederationtls_tcp[*].fqdn,
  )
}
