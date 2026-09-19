terraform {
  required_version = "~> 1.10" # OpenTofu 1.10.x line

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.65"
    }
  }
}
