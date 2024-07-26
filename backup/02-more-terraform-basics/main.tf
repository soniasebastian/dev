variable "iam_user_name_prefix" {
  type    = string #any, number, bool, list, map, set, object, tuple
  default = "my_iam_user"
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.46"
}

resource "aws_iam_user" "my_iam_users" {
  count = 3
  name  = "${var.iam_user_name_prefix}_${count.index}"
}



# COMMANDS

# terraform plan -0 iam.tfplan
# terraform apply iam.tfplan
# terraform validate
# terraform fmt
# terraform console
# terraform show
# -target= 
# -auto-approve

