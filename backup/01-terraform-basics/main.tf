provider "aws" {
    region = "us-east-1"
    version ="~> 2.46"
    }

# plan - execute 
resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "my-s3-bucket-sonia-001"
 versioning {
 enabled = true
    }
}

# STATE  
# DESIRED-KNOWN-ACTUAL 



resource "aws_iam_user" "my_iam_user" {
  name = "my_iam_user_abc_updated"
}