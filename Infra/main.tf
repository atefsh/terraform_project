provider "aws" {
  region = var.region

  default_tags {
    tags = var.default_tags
  }
}

terraform {
  backend "s3" {
    bucket = "atefs-terraform-project"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}

#--- Define new VPC ---
resource "aws_vpc" "new_vpc" {
  cidr_block = "${var.private_ip_address}${var.vpc_netmask}"
  tags = {
    Name = "New-VPC"
  }
}

#--- Definde subnet for availability zone a ---
resource "aws_subnet" "new_subnet_zone_a" {
  vpc_id     = aws_vpc.new_vpc.id 
  cidr_block = "${var.private_ip_address_zone_a}${var.zone_netmask}" 
  map_public_ip_on_launch = "true" # attach public ip
  availability_zone = "${var.region}a"

  tags = {
    Name = "Subnet-Zone-A"
  }

}

#--- Definde subnet for availability zone b ---
resource "aws_subnet" "new_subnet_zone_b" {
  vpc_id     = aws_vpc.new_vpc.id 
  cidr_block = "${var.private_ip_address_zone_b}${var.zone_netmask}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.region}b"

  tags = {
    Name = "Subnet-Zone-B"
  }

}

#--- Definde internet geteway to attach VPC to it ---
resource "aws_internet_gateway" "new_igw" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name = "VPC-IGW"
    }
}

#--- Definde route table for all public traffic and attach VPC ---
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name = "Public-route-table"
  }
}

#--- Definde route record for all public traffic and attach internet getaway ---
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = var.public_cidr_block
  gateway_id             = aws_internet_gateway.new_igw.id
}

#--- Associate subnet to route record for zone A ---
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.new_subnet_zone_a.id
  route_table_id = aws_route_table.public_route_table.id
}

#--- Associate subnet to route record for zone B ---
resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.new_subnet_zone_b.id
  route_table_id = aws_route_table.public_route_table.id
}

