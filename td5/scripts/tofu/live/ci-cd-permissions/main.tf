provider "aws" {
  region = "us-east-2"
}

module "oidc_provider" {
  source = "github.com/YoussefJ04/lab5//td5/scripts/tofu/modules/github-aws-oidc"

  provider_url = "https://token.actions.githubusercontent.com"
}

module "iam_roles" {
  source = "github.com/YoussefJ04/lab5//td5/scripts/tofu/modules/gh-actions-iam-roles"

  name              = "lambda-sample"
  oidc_provider_arn = module.oidc_provider.oidc_provider_arn

  # Pour les 3 rôles : tests, plan, apply
  enable_iam_role_for_testing = true
  enable_iam_role_for_plan    = true
  enable_iam_role_for_apply   = true

  # IMPORTANT : ton repo GitHub
  github_repo = "YoussefJ04/lab5"

  lambda_base_name          = "lambda-sample"
  tofu_state_bucket         = "youssefj04-lab5-tofu-state"
  tofu_state_dynamodb_table = "youssefj04-lab5-tofu-locks"
}
