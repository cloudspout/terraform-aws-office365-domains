# Terraform / OpenTofu AWS® Microsoft 365® Domains module

This module creates the AWS Route 53 records required to operate a self-managed
Microsoft 365 (Office 365) domain: Exchange Online mail flow (MX), SPF, DKIM,
Outlook autodiscover and — optionally — DMARC, Intune/MDM enrollment and the
legacy Skype for Business Online records.

It targets **OpenTofu / Terraform `1.10+`** and the **`hashicorp/aws` `~> 6.65`**
provider.

## Usage

```hcl
resource "aws_route53_zone" "example_com" {
  name = "example.com"
}

module "office365_domains" {
  source  = "cloudspout/office365-domains/aws"
  version = "~> 1.0"

  zone_id     = aws_route53_zone.example_com.zone_id
  domain_name = aws_route53_zone.example_com.name

  mx_record = "0 example-com.mail.protection.outlook.com"
  domainkeys = [
    "selector1-domain-com._domainkey.account.onmicrosoft.com",
    "selector2-domain-com._domainkey.account.onmicrosoft.com",
  ]
}
```

## Records created

Always created:

* **MX** – Exchange Online inbound mail (`mx_record`).
* **TXT (SPF)** – defaults to `v=spf1 include:spf.protection.outlook.com -all`.
* **CNAME `selector1._domainkey` / `selector2._domainkey`** – DKIM.
* **CNAME `autodiscover`** – `autodiscover.outlook.com`.

Optional:

* **TXT (`_dmarc`)** – set `dmarc_record` to publish a DMARC policy.
* **TXT (domain ownership)** – set `domain_ownership_verification_code`.
* **CNAME `enterpriseregistration` / `enterpriseenrollment`** – set `enable_mdm = true` for Intune/MDM.
* **Legacy Skype for Business** (`sip`, `lyncdiscover`, `_sip._tls` SRV, `_sipfederationtls._tcp` SRV) – set `enable_skype_for_business = true`. Not required for Microsoft Teams; Skype for Business Online was retired on 2021-07-31.

## Inputs

| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `zone_id` | `string` | – | yes | Route 53 hosted zone ID for the domain. |
| `domain_name` | `string` | – | yes | The domain name, e.g. `example.com`. |
| `mx_record` | `string` | – | yes | MX record value including priority. |
| `domainkeys` | `list(string)` (len 2) | – | yes | The two DKIM CNAME targets. |
| `spf_record` | `string` | `v=spf1 include:spf.protection.outlook.com -all` | no | Apex SPF/TXT value. |
| `domain_ownership_verification_code` | `string` | `null` | no | `MS=ms XXXXXXXX` ownership code. |
| `dmarc_record` | `string` | `null` | no | DMARC policy TXT value for `_dmarc`. |
| `ttl` | `number` | `3600` | no | TTL (seconds) for all records. |
| `enable_mdm` | `bool` | `false` | no | Create Intune/MDM enrollment records. |
| `enable_skype_for_business` | `bool` | `false` | no | Create legacy Skype for Business records. |

## Outputs

`mx_fqdn`, `spf_txt_fqdn`, `dkim_fqdns`, `autodiscover_fqdn`, `dmarc_fqdn`,
`mdm_fqdns`, `skype_for_business_fqdns`.

## Examples

* [Basic](./examples/basic/main.tf) – the core Microsoft 365 email records.
* [Complete](./examples/complete/main.tf) – all records including DMARC, MDM, domain verification and Skype for Business.

## Upgrading from `0.x`

Version `1.0` is a breaking change:

* The `zone` object input was replaced by discrete `zone_id` and `domain_name`
  inputs. Update your module call accordingly.
* The redundant apex `NS` record is no longer managed (Route 53 manages apex NS
  automatically). If you upgrade an existing deployment, run
  `tofu state rm 'module.<name>.aws_route53_record.ns'` to drop it from state.
* The SIP / Skype for Business and `lyncdiscover` records are now opt-in via
  `enable_skype_for_business` (default `false`).
* The default SPF value no longer includes the `a` mechanism, matching the
  current Microsoft 365 recommendation.
* `txt_record` (a `list(string)`) was replaced by the single `spf_record`
  (`string`).

-----------

Microsoft 365® and Office 365® are either registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.

Amazon Web Services (AWS) are trademarks of Amazon.com, Inc. or its affiliates in the United States and/or other countries.

All other third-party trademarks are the property of their respective owners.
