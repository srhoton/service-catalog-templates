# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.63.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "aws" {}

provider "github" {
  token        = jsondecode(data.aws_secretsmanager_secret_version.service-catalog-github-token.secret_string)["GITHUB_API_TOKEN"]
}

data "aws_secretsmanager_secret" "service-catalog-github-token" {
  name = "service-catalog-testing-github-api-token"
}

data "aws_secretsmanager_secret_version" "service-catalog-github-token" {
  secret_id = data.aws_secretsmanager_secret.service-catalog-github-token.id
}

resource "random_string" "random" {
  length  = var.random_string_length
  special = false
  upper   = false
}

resource "aws_s3_bucket" "my-bucket" {
  bucket = "aws-tfc-service-catalog-example-${random_string.random.result}"
}

resource "github_repository" "example" {
  name = "service-catalog-testing"
  description = "AWS Service Catalog Testing"
  private = true
}

variable "random_string_length" {
  type        = number
  description = "Length of the random string to append to the bucket name"
  default     = 16
}

output "bucket_name" {
  value = aws_s3_bucket.my-bucket.bucket
}
