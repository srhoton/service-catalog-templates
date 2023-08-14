terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "github" {
  token        = jsondecode(data.aws_secretsmanager_secret_version.service-catalog-github-token.secret_string)["GITHUB_API_TOKEN"]
}
