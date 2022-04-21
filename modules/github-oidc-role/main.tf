resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}

resource "aws_iam_role" "this" {
  name = "${var.name}-cicd-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = {
      Effect = "Allow"
      Action = [
        "sts:AssumeRoleWithWebIdentity"
      ]
      Principal = {
        Federated = aws_iam_openid_connect_provider.github.arn
      }
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:${var.organization}/${var.repository}:*"
        }
      }
    }
  })

  inline_policy {
    name = "custom_permissions"

    policy = jsonencode({
      Version   = "2012-10-17"
      Statement = var.role_access_statements
    })
  }
}

