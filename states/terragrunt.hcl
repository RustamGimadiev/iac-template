locals {
  global_vars      = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  account_id  = local.account_vars.locals.aws_account_id
  aws_region  = local.region_vars.locals.aws_region
  alias       = local.global_vars.locals.alias
  environment = local.environment_vars.locals.environment
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region              = "${local.aws_region}"
  allowed_account_ids = ["${local.account_id}"]

  default_tags {
   tags = {
     Environment = "${local.environment}"
     Owner       = "gimadiev.kzn@yandex.ru"
     Project     = "${upper(local.alias)}"
     Terraform   = "true"
   }
 }
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.alias}-terragrunt-states-${local.aws_region}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "${local.alias}-terragrunt-states-locks-${local.aws_region}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
  local.global_vars.locals,
)
