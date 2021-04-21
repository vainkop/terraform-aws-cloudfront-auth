# Terraform CloudFront Auth

[![Version: v1.0.0][version-badge]][changelog]
[![License: GPL v3][license-badge]][license]

## Introduction

This module will build a website that is protected by an
[OpenId](https://openid.net/what-is-openid/)-compatible
authentication provider.  It will provision a private S3
bucket, [Cloudfront](https://aws.amazon.com/cloudfront/),
and deploy a customized Lambda function using
[Lambda@Edge](https://aws.amazon.com/lambda/edge/).

Currently only OKTA is supported, but can easily be extended
to support others (Google/Microsoft/GitHub/Auth0/Centrify).

## Based on

This project uses the nodejs code from [Widen][widen] for the Lambda
function.  Their repository includes a `build.js` script that
interactively prompts for configuration items (client_id, client_secret,
etc.) and builds the lambda zip file.  This does not lend itself well
to automation; this repository replaces that logic with `build.tf` and
`local-exec` resources create the archive.

The Scale Factory team created the (now hibernating)
[terraform-cloudfront-auth](https://github.com/scalefactory/terraform-cloudfront-auth)
project to allow passing environment variables to the Widen `build.js`
script.  Their project still requires executing the nodejs script,
which does not work for environments where those dependencies are not
available, such as a [Terraform Cloud](https://www.terraform.io/cloud)
runner.

## Caveats

The
[archive_file](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/archive_file)
data source is used in this project.  Terraform will always generate
a plan to modify resources, even when a `terraform apply` will make no changes.
This will generate false positives when `terraform plan` is run periodically
to check for configuration drift.

## Usage
An example is included in the `example/` directory.

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | AWS Region. | `string` | n/a | yes |
| hostname | Hostname of the managed website. | `string` | n/a | yes |
| client\_id | OKTA client\_id. | `string` | n/a | yes |
| client\_secret | OKTA client\_secret. | `string` | n/a | yes |
| redirect\_uri | AWS redirect\_uri. | `string` | n/a | yes |
| base\_url | OKTA base\_url. | `string` | n/a | yes |
| acm\_cert\_arn | ARN of AWS Certificate Manager certificate for website. | `string` | n/a | yes |
| route53\_zone\_name | AWS Route53 zone name. | `string` | n/a | yes |
  
## Outputs

| Name | Description |
|------|-------------|
| cloudfront\_distribution | CloudFront distribution |
| lambda\_function | Lambda function |
| s3\_bucket | S3 bucket |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-restore -->

## License

This project is licensed under the [GNU GPLv3][gpl].  Please use and
change to suit your needs.

This repository includes the source from [Widen's cloudfront-auth
project][widen] and its dependencies, compliant with the project's
[license][widen-license].

---
[license-badge]: https://img.shields.io/badge/License-GPLv3-blue.svg
[gpl]: https://www.gnu.org/licenses/quick-guide-gplv3.html
[license]: ./LICENSE
[widen-license]: ./cloudfront-auth/LICENSE
[widen]: https://github.com/Widen/cloudfront-auth/
[version-badge]: https://img.shields.io/badge/version-1.0.0-blue.svg
[license-badge]: https://img.shields.io/badge/License-GPLv3-blue.svg
[changelog]: ./CHANGELOG.md