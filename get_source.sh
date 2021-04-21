#!/bin/bash
#
# download source and dependencies for inclusion into the repository

set -euxo pipefail
DIR="cloudfront-auth"

rm -rf cloudfront-auth-master "$DIR"
curl -s -L https://github.com/vainkop/terraform-aws-cloudfront-auth/releases/download/v1.0.0/master.zip -o master.zip
unzip -q master.zip
rm master.zip
mv cloudfront-auth-master "$DIR"
(cd "$DIR" && npm install --silent)
grep -v "node_modules" ${DIR}/.gitignore > ${DIR}/.gitignore.new && mv ${DIR}/.gitignore{.new,}
module "cloudfront-auth" {
  source  = "vainkop/cloudfront-auth/aws"
  version = "1.0.0"
  #
}