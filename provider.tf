terraform {
  backend "s3" {}
}

provider "aws" {
  region  = var.region
}

terraform {
  required_version = ">= 0.14.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.37.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }
}