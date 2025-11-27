variable "name" {
  description = "Base name for the roles"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider"
  type        = string
}

variable "enable_iam_role_for_testing" {
  type        = bool
  default     = false
  description = "Create IAM role for tests"
}

variable "enable_iam_role_for_plan" {
  type        = bool
  default     = false
  description = "Create IAM role for tofu plan"
}

variable "enable_iam_role_for_apply" {
  type        = bool
  default     = false
  description = "Create IAM role for tofu apply"
}

variable "github_repo" {
  description = "GitHub repo in the form owner/name (e.g. YoussefJ04/lab5)"
  type        = string
}

variable "lambda_base_name" {
  description = "Base name of the lambda resources"
  type        = string
}

variable "tofu_state_bucket" {
  description = "Name of the S3 bucket for OpenTofu state"
  type        = string
}

variable "tofu_state_dynamodb_table" {
  description = "Name of the DynamoDB table for locks"
  type        = string
}
