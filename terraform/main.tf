terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"  # Mumbai — Bangladesh এর কাছের region
}

# Key Pair
resource "aws_key_pair" "devops360_key" {
  key_name   = "devops360-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Security Group
resource "aws_security_group" "devops360_sg" {
  name        = "devops360-sg"
  description = "DevOps360 Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "devops360" {
  ami                    = "ami-0f58b397bc5c1f2e8"  # Ubuntu 22.04 Mumbai
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.devops360_key.key_name
  vpc_security_group_ids = [aws_security_group.devops360_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y python3-pip python3-venv nginx
              cd /home/ubuntu
              git clone https://github.com/YOUR_USERNAME/devops360.git
              cd devops360
              python3 -m venv venv
              source venv/bin/activate
              pip install flask gunicorn
              gunicorn --bind 0.0.0.0:5000 app:app --daemon
              EOF

  tags = {
    Name = "devops360"
  }
}

# Output: Public IP
output "public_ip" {
  value       = aws_instance.devops360.public_ip
  description = "EC2 Public IP Address"
}

# Elastic IP
resource "aws_eip" "devops360_eip" {
  instance = aws_instance.devops360.id
  domain   = "vpc"
}

output "elastic_ip" {
  value       = aws_eip.devops360_eip.public_ip
  description = "Fixed Elastic IP"
}
