data "aws_secretsmanager_secret" "service-catalog-github-token" {
  name = "service-catalog-testing-github-api-token"
}

data "aws_secretsmanager_secret_version" "service-catalog-github-token" {
  secret_id = data.aws_secretsmanager_secret.service-catalog-github-token.id
}
