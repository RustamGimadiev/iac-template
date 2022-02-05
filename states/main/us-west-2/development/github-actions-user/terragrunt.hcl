include {
  path = find_in_parent_folders()
}

locals {
  global_vars         = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  alias               = local.global_vars.locals.alias
  github_repository   = local.global_vars.locals.repository
  github_organization = local.global_vars.locals.organization
}

terraform {
  source = "${dirname(find_in_parent_folders())}/../modules/github-oidc-role"
}

inputs = {
  name         = local.alias
  repository   = local.github_repository
  organization = local.github_organization
}
