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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mainVpc.id
    tags = {
    "environment" = "dev"
    "resource"    = "igw"
    "Name" = "igw"
  }
}

resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.mainVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "environment" = "dev"
    "resource"    = "routetable"
    "Name" = "main_rt"
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
resource "aws_main_route_table_association" "mainroute_associate" {
  vpc_id = aws_vpc.mainVpc.id
  route_table_id = aws_route_table.main_rt.id
}
resource "aws_route_table_association" "coreSubnet_to_main_rt" {
  subnet_id = aws_subnet.coreSubnet.id
  route_table_id = aws_route_table.main_rt.id
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

resource "aws_network_interface" "webserver_nwinterface" {
  subnet_id = aws_subnet.coreSubnet.id
  security_groups = [
    aws_security_group.coreSG.id
  ]
  tags = {
    "environment" = "dev"
    "resource"    = "nwinterface-core"
    "Name" = "webserver_nwinterface"
  }
  
}

resource "aws_key_pair" "forLiva" {
  key_name = "forLiva_2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCAXeJFEjJUuTWyupEtmMeWvEft1ZfHPr6sEPGpFvY3ZaaK/H4sfBQGT4puO14e3Q76BSuv2F+mjczK2MMC9QCbDjhfJhRTIqw00BAg33UQDoNIwFy4TMFN076Vlk5eNLYxG6JE6T29x4bNdE3j2V02G2NIN4bpaINED7zSv/DVdFv6/U9en3mhUJq+N4iusluZ7xcIuwhvpOJN9M5bu2549Vigaw0Ge/HuGxbfWYUspghBZ5V+BSI4NBBUGAJwZUQQ9MMMLcx2hR8JAYVFBKiVGpERI8hkvZ+AA3+tlh9gkPHzguVgeIAeZhGdMu74lo/za0Be+s3QCeYIxbPCt0hr"
}

resource "aws_instance" "webserver" {
  ami = var.livaAMIId
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.webserver_nwinterface.id
    device_index = 0
  }
  key_name = aws_key_pair.forLiva.key_name
  user_data = file("initial_setup.sh")
  tags = {
    "environment" = "dev"
    "resource"    = "ec2"
    "Name" = "webserver"
  }  
}