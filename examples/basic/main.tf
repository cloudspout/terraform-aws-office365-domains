terraform {
  required_version = "~> 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.65"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_route53_zone" "example_com" {
  name = "example.com"
}

module "office365_domains" {
  source = "../.."

  zone_id     = aws_route53_zone.example_com.zone_id
  domain_name = aws_route53_zone.example_com.name

  mx_record = "0 example-com.mail.protection.outlook.com"
  domainkeys = [
    "selector1-domain-com._domainkey.account.onmicrosoft.com",
    "selector2-domain-com._domainkey.account.onmicrosoft.com",
  ]
}
