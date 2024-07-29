terraform {
  backend "s3" {
    bucket         = "dev-application-backend-state-sonia-abc"
    key            = "dev/07-backend-state/users/backend-state"
    region         = "us-east-1"
    dynamodb_table = "dev_application_locks"
    encrypt        = true
  }
}

provider "aws" {
    region = "us-east-1"
   // version = "~> 2.46"
}

resource "aws_iam_user" "my_iam_user" {
  name = "my_iam_user_abc"
}


