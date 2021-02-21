terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "acharya"
  region  = "us-east-1"
}

resource "aws_vpc" "mainVpc" {
  cidr_block       = var.mainVPCCIDRBlock
  instance_tenancy = var.mainVPCInstanceTenancy

  tags = {
    "environment" = "dev"
    "resource"    = "vpc"
    "Name" = "mainVpc"
  }
}

resource "aws_subnet" "coreSubnet" {
  vpc_id                  = aws_vpc.mainVpc.id
  cidr_block              = var.coreSNCIDRBlock
  map_public_ip_on_launch = var.coreSNMapPublicIp

  tags = {
    "environment" = "dev"
    "resource"    = "subnet-core"
    "Name" = "coreSubnet"
  }

}

resource "aws_security_group" "coreSG" {
  name        = "coreSG"
  description = "Allow TLS for ingress/egress"
  vpc_id      = aws_vpc.mainVpc.id

  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "ingress rule for coreSG"
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
  },
  {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "ingress rule for coreSG"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  },
  {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "ingress rule for coreSG"
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
  }]

  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "egress rul for coreSG"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]

  tags = {
    "environment" = "dev"
    "resource"    = "coreSG"
  }
}