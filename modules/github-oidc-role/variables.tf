variable "organization" {
  type        = string
  description = "GitHub organization to scope access"
}

variable "repository" {
  type        = string
  description = "GitHub repository to scope access"
}

variable "name" {
  type        = string
  description = "A name prefix for all new created resources"
}

variable "role_access_statements" {
  type = list(any)
  default = [{
    Action   = ["sts:GetCallerIdentity"]
    Effect   = "Allow"
    Resource = "*"
  }]
  description = "A set of statements for IAM policy to be attached to CI user role"
}
