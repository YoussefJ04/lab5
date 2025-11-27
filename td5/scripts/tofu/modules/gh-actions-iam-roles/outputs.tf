output "lambda_test_role_arn" {
  description = "IAM role ARN for tests"
  value       = length(aws_iam_role.test) > 0 ? aws_iam_role.test[0].arn : null
}

output "lambda_deploy_plan_role_arn" {
  description = "IAM role ARN for tofu plan"
  value       = length(aws_iam_role.plan) > 0 ? aws_iam_role.plan[0].arn : null
}

output "lambda_deploy_apply_role_arn" {
  description = "IAM role ARN for tofu apply"
  value       = length(aws_iam_role.apply) > 0 ? aws_iam_role.apply[0].arn : null
}
