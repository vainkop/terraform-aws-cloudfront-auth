terragrunt_version_constraint = "= v0.28.9"
terraform_version_constraint  = ">= 0.14.10"

remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "example-terraform-state-bucket"
    region         = "us-east-1"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    acl            = "bucket-owner-full-control"
    dynamodb_table = "example-dynamodb-table"
  }
}


include {
  path = find_in_parent_folders()
}

terraform {
  source  = "vainkop/cloudfront-auth/aws"
  version = "1.0.0"
}

locals { common_vars = yamldecode(file("values.yaml")) }

inputs = local.common_vars
