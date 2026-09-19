variable "zone_id" {
  type        = string
  description = "The Route 53 hosted zone ID in which to create the records."
}

variable "domain_name" {
  type        = string
  description = "The domain name (matching the hosted zone) to configure for Microsoft 365, e.g. `example.com`."
}

variable "mx_record" {
  type        = string
  description = "The Microsoft 365 MX record value including priority, e.g. `0 example-com.mail.protection.outlook.com`."
}

variable "domainkeys" {
  type        = list(string)
  description = "The two DKIM CNAME targets (selector1 and selector2) from the Microsoft 365 admin center."

  validation {
    condition     = length(var.domainkeys) == 2
    error_message = "Exactly two DKIM domain keys (selector1 and selector2) must be provided."
  }
}

variable "spf_record" {
  type        = string
  default     = "v=spf1 include:spf.protection.outlook.com -all"
  description = "The SPF value published as an apex TXT record. Defaults to the Microsoft 365 recommended value."
}

variable "domain_ownership_verification_code" {
  type        = string
  default     = null
  description = "Optional Microsoft domain-ownership TXT verification code, e.g. `MS=ms XXXXXXXX`. Leave `null` once ownership is verified."
}

variable "dmarc_record" {
  type        = string
  default     = null
  description = "Optional DMARC policy published as a TXT record at `_dmarc`, e.g. `v=DMARC1; p=quarantine; rua=mailto:dmarc@example.com`. Leave `null` to skip."
}

variable "ttl" {
  type        = number
  default     = 3600
  description = "TTL (in seconds) applied to the created records."
}

variable "enable_mdm" {
  type        = bool
  default     = false
  description = "Create the Intune/MDM enrollment CNAME records (`enterpriseregistration`, `enterpriseenrollment`)."
}

variable "enable_skype_for_business" {
  type        = bool
  default     = false
  description = "Create the legacy Skype for Business Online records (SIP CNAME/SRV and lyncdiscover). Not required for Microsoft Teams; Skype for Business Online was retired on 2021-07-31."
}
