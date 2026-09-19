# Terraform AWS Microsoft 365 Domains Module
## Complete example

This example uses all features of the module: it creates the email related
entries in the host zone plus:

* MS domain-ownership verification code as a TXT record
* DMARC policy TXT record (`_dmarc`)
* Intune / MDM `CNAME` enrollment records
* Legacy Skype for Business Online records (SIP CNAME/SRV and `lyncdiscover`)
