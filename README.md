# Infastructure as a Code
This repository provides a required minimum setup of the IaC with default Terragrunt code layout and CI/CD pipelines.

## Required GitHub secrets
| Name | Description |
|---|---|
|`AWS_ACCESS_KEY_ID`|AWS access key to make programmatic calls to AWS |
|`AWS_SECRET_ACCESS_KEY`|AWS secret key |
|`IAC_PAT`|Personal access tokens (PATs) for authentication to GitHub when using the GitHub API or the command line|
|`INFRACOST_API_KEY`|Free API key for Infracost|

## Structure
### `modules`
Contains in-house Terraform modules, best practice here is to use a separate repository for Terraform modules, but in some cases better to keep specific modules here. By default, CI pipeline is enabled for this folder, if pull request contains changes for files placed in `modules`, then CI will detect all updated modules and will perform some basic checks (formatting, code validation, and apply linter).

### `states`
This is a root folder for Terragrunt, all nested folders are using the followed convection: each of them is placed with tree default layer separators (AWS account, region, and environment). In the future, users could extend those layers with their own.

### `generated`
The folder with Terraform generated resources basically is designed to use with [SAK](https://github.com/provectus/swiss-army-kube) modules annd used by ArgoCD.

Algorithm of work:
1. Terragrunt applies Terraform code and generates required files in its `.terrafrom-cache` folder.
2. CI pipelines after finishing applying code perform checking state file for resources with `local_file` type and copy all of them with keeping original Terragrunt folder path to `generated` folder and commit them.

> **NOTE**: CI or Terraform do not perform deletions from that folder, so users must clean up unused files by themself.

## How to use
1. Copy this repository under your organization.
2. Fill up all required GitHub secrets.
3. Perform CI and Terragrunt layout modifications based on your needs
4. Manually perform first `terragrunt apply` for `terraform-states` Terragrunt folder (by default placed in `main/us-west-2/development/terraform-states`, the path could be different if it was changed on the third step).
