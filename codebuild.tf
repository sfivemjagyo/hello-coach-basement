resource "aws_s3_bucket" "example" {
  bucket = "demo11-sample-bucket-tests"

  versioning {
    enabled = true
  }
}

resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  role = aws_iam_role.example.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": "*",
        "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_codebuild_project" "example" {
  name          = "test-project"
  description   = "test_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.example.arn

  artifacts {
    type = "S3"
    location = "${aws_s3_bucket.example.bucket}"
    path = "sample-application"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/${var.github_owner}/${var.github_repository}.git"
    buildspec       = "./pipeline/node_build_deploy.yaml"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "master"

  tags = {
    Environment = "Test"
  }
}

resource "aws_codebuild_webhook" "example" {
  project_name = aws_codebuild_project.example.name

  depends_on = [
    aws_codebuild_project.example,
  ]
}

resource "github_repository_webhook" "example" {
  active     = true
  events     = ["push"]
  repository = "sample-app"

  configuration {
    url          = aws_codebuild_webhook.example.payload_url
    secret       = aws_codebuild_webhook.example.secret
    content_type = "json"
    insecure_ssl = false
  }
}


