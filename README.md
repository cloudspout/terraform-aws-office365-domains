# Terraform AWS® Office365® Domains module

This module for Terraform (`0.12+`) helps to create the required zone entries to 
operate a self-managed Office365 domain.

## Usage

The following variables are *required*:

* `zone` - The `aws_route53_zone` to use
* `mx_record` - The created MX record (whole line including weight)
* `domainkeys` - The *two* domain keys for DKIM

```hcl
resource "aws_route53_zone" "example_com" {
  name = "example.com"
}

module "office365-domains" {
  source  = "cloudspout/office365-domains/aws"
  version = "0.0.6"

  zone      = aws_route53_zone.example_com
  mx_record = "0 example-comNNc.mail.protection.outlook.com."
  domainkeys = [
    "selector1-domain-comNNc._domainkey.account.onmicrosoft.com",
    "selector2-domain-comMMc._domainkey.account.onmicrosoft.com"
  ]
}
```

The following variabels are *optional*:

* `domain_ownership_verification_code` - The domain ownership registration code in the format `MS=ms XXXXXXXX`. Can be skipped if the ownership is already confirmed in Office365
* `txt_record` - The TXT record for the root record - by default the Office365 SPF entry: `"v=spf1 a include:spf.protection.outlook.com -all"`
* `enable_mdm` -  Add two CNAME records for Mobile Device Management (MDM) for Office 365 if set to `true`

## Examples

Please check the examples in the [`examples/`](https://github.com/cloudspout/terraform-aws-office365-domains/tree/master/examples) folder:
* [Basic](https://github.com/cloudspout/terraform-aws-office365-domains/blob/master/examples/basic/main.tf) - Creates just the basic Office365 email records in the host zone
* [Complete](https://github.com/cloudspout/terraform-aws-office365-domains/blob/master/examples/complete/main.tf) - Creates all the Office365 records including SIP, MDM & domain verification.

-----------

Office365® are either registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.

Amazon Web Services (AWS) are trademarks of Amazon.com, Inc. or its affiliates in the United States and/or other countries.

All other third-party trademarks on the site are the property of their respective owners.
