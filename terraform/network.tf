provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "OmarVPC"
  }
}

resource "aws_internet_gateway" "inter" {
  vpc_id = aws_vpc.main.id
  tags ={
    Name = "Internet"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_b"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.inter.id

  }
  tags = {
    Name = "PublicTable"
  }
}

resource "aws_route_table_association" "ps-route-table-association-a" {
  subnet_id = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "ps-route-table-association-b" {
  subnet_id = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}
