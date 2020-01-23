variable "zone" {
  type = object({
    id           = string
    name         = string
    zone_id      = string
    name_servers = list(string)
  })

  description = "The `aws_route53_zone` to use"
}

variable "mx_record" {
  type = string

  description = "The created MX record (whole line including weight)"
}

variable "domainkeys" {
  type = tuple([string, string])

  description = "The two domain keys for DKIM"
}

variable "txt_record" {
  type = list(string)

  default = [
    "v=spf1 a include:spf.protection.outlook.com -all"
  ]

  description = "The TXT record for the root record - by default the Office365 SPF entry"
}

variable "domain_ownership_verification_code" {
  type = string

  default = "MS=ms XXXXXXXX"

  description = "The domain ownership registration code in the format `MS=ms XXXXXXXX`. Can be skipped if the ownership is already confirmed in Office365."
}

variable "ip" {
  type    = string
  
  default = "0.0.0.0"

  description = "IP address for the root A and `www` A record"
}

variable "enable_mdm" {
  type = bool

  default = false

  description = "Add two CNAME records for Mobile Device Management (MDM) for Office 365 if set to `true`"
}
