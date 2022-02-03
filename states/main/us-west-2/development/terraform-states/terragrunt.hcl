locals {
  global_vars = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  aws_region  = local.region_vars.locals.aws_region
  alias       = local.global_vars.locals.alias
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "${dirname(find_in_parent_folders())}/../modules/terraform-resources"
}

inputs = {
  name   = local.alias
  region = local.aws_region
}
