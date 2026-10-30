provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }

}
 output "subnet_id" {
    value = aws_subnet.main.id
  }

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "network"
subnets            = [aws_subnet.main.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}
