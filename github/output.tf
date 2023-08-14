output "example" {
  value = jsondecode(data.aws_secretsmanager_secret_version.service-catalog-github-token.secret_string)["GITHUB_API_TOKEN"]
  sensitive = true
}
