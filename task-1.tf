provider "aws" {
  access_key = ""                          // Please write AWS account access key
  secret_key = ""                          // Please write AWS account secret key
  region     = var.region
}

data "aws_availability_zones" "workzone" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_ami" "latest_ubuntu_linux" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "Ubuntu" {
  ami                    = data.aws_ami.latest_ubuntu_linux.id
  instance_type          = var.instance_type
  key_name               = "My-Key"                     // Please write your key's name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name    = "My Server"
    Owner   = "Artak"
    Project = "Terraform task"
  }
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc" "My_VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "My_VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.My_VPC.id
  availability_zone = data.aws_availability_zones.workzone.names[1]
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "public_subnet"
  }
}