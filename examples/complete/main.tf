resource "aws_route53_zone" "example_com" {
  name = "example.com"
}

module "office365_domains" {
  source = "github.com/cloudspout/terraform-aws-office365-domains"

  zone      = aws_route53_zone.example_com
  mx_record = "0 example-comNNc.mail.protection.outlook.com."
  domainkeys = [
     "selector1-domain-comNNc._domainkey.account.onmicrosoft.com",
    "selector2-domain-comMMc._domainkey.account.onmicrosoft.com"
  ]

  domain_ownership_verification_code = "MS=ms 12345678"
  enable_mdm                         = true
}