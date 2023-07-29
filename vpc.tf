# Internet VPC
resource "aws_vpc" "EKS-VPC" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "EKS-VPC"
  }
}

# Subnets
resource "aws_subnet" "EKS-public-1" {
  vpc_id                  = aws_vpc.EKS-VPC.id
  cidr_block              = "10.0.21.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "EKS-public-1"
  }
}

resource "aws_subnet" "EKS-public-2" {
  vpc_id                  = aws_vpc.EKS-VPC.id
  cidr_block              = "10.0.22.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "EKS-public-2"
  }
}

resource "aws_subnet" "EKS-public-3" {
  vpc_id                  = aws_vpc.EKS-VPC.id
  cidr_block              = "10.0.23.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1c"

  tags = {
    Name = "EKS-public-3"
  }
}

resource "aws_subnet" "EKS-private-1" {
  vpc_id                  = aws_vpc.EKS-VPC.id
  cidr_block              = "10.0.24.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "EKS-private-1"
  }
}

resource "aws_subnet" "EKS-private-2" {
  vpc_id                  = aws_vpc.EKS-VPC.id
  cidr_block              = "10.0.25.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "EKS-private-2"
  }
}

resource "aws_subnet" "EKS-private-3" {
  vpc_id                  = aws_vpc.EKS-VPC.id
  cidr_block              = "10.0.26.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1c"

  tags = {
    Name = "EKS-private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "EKS-VPC-gw" {
  vpc_id = aws_vpc.EKS-VPC.id

  tags = {
    Name = "EKS-VPC"
  }
}

# route tables
resource "aws_route_table" "EKS-publicRT" {
  vpc_id = aws_vpc.EKS-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EKS-VPC-gw.id
  }

  tags = {
    Name = "EKS-publicRT-1"
  }
}

# route associations public
resource "aws_route_table_association" "EKS-publicRT-1-a" {
  subnet_id      = aws_subnet.EKS-public-1.id
  route_table_id = aws_route_table.EKS-publicRT.id
}

resource "aws_route_table_association" "EKS-publicRT-2-a" {
  subnet_id      = aws_subnet.EKS-public-2.id
  route_table_id = aws_route_table.EKS-publicRT.id
}

resource "aws_route_table_association" "EKS-VPC-publicRT-3-a" {
  subnet_id      = aws_subnet.EKS-public-3.id
  route_table_id = aws_route_table.EKS-publicRT.id
}



