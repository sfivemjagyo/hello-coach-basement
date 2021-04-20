resource "aws_codepipeline" "pipeline" {
  name     = "incredible-website-pipeline"
  role_arn = "${aws_iam_role.codepipeline_role.arn}"

  artifact_store {
    location = "${aws_s3_bucket.example.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["sampleapp"]

      configuration = {
        S3Bucket = "${aws_s3_bucket.example.bucket}"
        S3ObjectKey = "sample-application/test-project/application_deploy.zip"
      }

      run_order = 1
    }
  }

  stage {
    name = "Deploy"

    action {
      name = "Deploy"
      category = "Deploy"
      owner = "AWS"
      provider = "ElasticBeanstalk"
      input_artifacts = ["sampleapp"]
      version = "1"

      configuration = {
        ApplicationName = "${aws_elastic_beanstalk_application.tftest.name}"
        EnvironmentName = "${aws_elastic_beanstalk_environment.tfenvtest.name}"
      }
    }
  }
}


resource "aws_iam_role" "codepipeline_role" {
  name = "test-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline_policy"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
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
EOF
}
