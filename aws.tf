provider "aws" {
  version    = "~> 3.0"
  region     = "us-east-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}
