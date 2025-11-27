variable "provider_url" {
  description = "OIDC provider URL (e.g. https://token.actions.githubusercontent.com)"
  type        = string
}

provider "aws" {
  region = "us-east-2"
}

# OIDC provider pour GitHub Actions
resource "aws_iam_openid_connect_provider" "this" {
  url = var.provider_url

  client_id_list = [
    "sts.amazonaws.com"
  ]

  # Empreinte pour token.actions.githubusercontent.com (GitHub OIDC)
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}

output "oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider"
  value       = aws_iam_openid_connect_provider.this.arn
}
