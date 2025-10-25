output "cd_user_access_key_id" {
  description = "AK"
  value       = aws_iam_access_key.cd.id
}

output "cd_user_secret_key_id" {
  description = "SK"
  value       = aws_iam_access_key.cd.secret
  sensitive   = true
}

output "erc_repo_app" {
  description = "ecr repo url for app"
  value       = aws_ecr_repository.app.repository_url
}

output "erc_repo_proxy" {
  description = "ecr repo url for proxy"
  value       = aws_ecr_repository.proxy.repository_url
}
