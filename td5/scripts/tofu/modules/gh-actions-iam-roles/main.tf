provider "aws" {
  region = "us-east-2"
}

locals {
  github_sub = "repo:${var.github_repo}:*"
}

data "aws_iam_policy_document" "github_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [local.github_sub]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

# Rôle pour les tests
resource "aws_iam_role" "test" {
  count = var.enable_iam_role_for_testing ? 1 : 0

  name               = "${var.name}-tests"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

# Rôle pour tofu plan
resource "aws_iam_role" "plan" {
  count = var.enable_iam_role_for_plan ? 1 : 0

  name               = "${var.name}-plan"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

# Rôle pour tofu apply
resource "aws_iam_role" "apply" {
  count = var.enable_iam_role_for_apply ? 1 : 0

  name               = "${var.name}-apply"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

# Ici, pour simplifier, on donne des droits larges (c’est un lab)
resource "aws_iam_role_policy_attachment" "test_admin" {
  count      = length(aws_iam_role.test)
  role       = aws_iam_role.test[0].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "plan_admin" {
  count      = length(aws_iam_role.plan)
  role       = aws_iam_role.plan[0].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "apply_admin" {
  count      = length(aws_iam_role.apply)
  role       = aws_iam_role.apply[0].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
