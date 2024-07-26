terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.46"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_default_vpc" "default" {}

//HTTP Server -> SG
//SG -> 80 TCP, 22 TCP, CIDR []

resource "aws_security_group" "http_server_sg" {
  name   = "http_server_sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http_server_sg"
  }
}

resource "aws_instance" "http_server" {
  ami                    = data.aws_ami.aws_linux_2_latest.id
  key_name               = "default_ec2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = tolist(data.aws_subnet_ids.default_subnets.ids)[0]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "echo Welcome to my DevOps learning - Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html",
      "sudo systemctl enable httpd" // Ensure httpd starts on boot
    ]
  }
  #provisioner "remote-exec" {
  #inline = [
  #"sudo yum install httpd -y",                                                                                  
  #"sudo service httpd start",                                                                                   
  # "echo Welcome to my DevOps learning - Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html"
  #]
  #}
}

# in28mins code

/*
variable "aws_key_pair" {
  default = "~/aws/aws_keys/default_ec2.pem"
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.46"
}

resource "aws_default_vpc" "default" {}

data "aws_subnet_ids" "default_subnets" {
  vpc_id = aws_default_vpc.default.id
}

data "aws_ami" "aws-linux-2-latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}


#HTTP Server -> SG
#SG-> 80 TCP, 22 TCP, CIDR ["0.0.0.0/0]
# plan - execute 

resource "aws_security_group" "http_server_sg" {
  name = "http_server_sg"
  #vpc_id = "vpc-038edb66ebd0b0b3a"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "http_server_sg"
  }
}

resource "aws_instance" "http_server" {
  #ami                    = "ami-0427090fd1714168b"
  ami = data.aws_ami.aws_linux_2_latest.id
  key_name               = "default_ec2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  // subnet_id              = "subnet-0461969d25c77cb1f"
  subnet_id = tolist(data.aws_subnet_ids.default_subnets.ids)[0]


  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                                       //install httpd 
      "sudo service httpd start",                                                                                        //start
      "echo Welcome to my DevOps learning - Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html" //copy a file
    ]
  }
}

*/




