provider "aws" {
  region = var.AWS_REGION
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Main vpc
resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.CUSTOM_VPC_CIDR_BLOCK
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.ENVIRONMENT}-vpc"
  }
}

#Public subnets
# public Sunbet 1
resource "aws_subnet" "custom_vpc_public_subnet_1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.CUSTOM_VPC_PUBLIC_SUBNET1_CIDR_BLOCK
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.ENVIRONMENT}_custom_vpc_public_subnet_1"
  }
}

# public Sunbet 2
resource "aws_subnet" "custom_vpc_public_subnet_2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.CUSTOM_VPC_PUBLIC_SUBNET2_CIDR_BLOCK
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.ENVIRONMENT}_custom_vpc_public_subnet_2"
  }
}

# private Sunbet 1
resource "aws_subnet" "custom_vpc_private_subnet_1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.CUSTOM_VPC_PRIVATE_SUBNET1_CIDR_BLOCK
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.ENVIRONMENT}_custom_vpc_private_subnet_1"
  }
}

# private Sunbet 2
resource "aws_subnet" "custom_vpc_private_subnet_2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.CUSTOM_VPC_PRIVATE_SUBNET2_CIDR_BLOCK
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.ENVIRONMENT}_custom_vpc_private_subnet_2"
  }
}

# internet gateway
resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "${var.ENVIRONMENT}_custom_vpc_custom_igw"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "custom_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.custom_igw]
}


# NAT gateway for private IP adresse
resource "aws_nat_gateway" "custom_nat_gtw" {
  allocation_id = aws_eip.custom_eip.id
  subnet_id     = aws_subnet.custom_vpc_public_subnet_1.id
  depends_on    = [aws_internet_gateway.custom_igw]
  tags = {
    Name = "${var.ENVIRONMENT}-custom-vpc-NAT-gateway"
  }
}


# Route table for public Architecture
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_igw.id
  }
  tags = {
    Name = "${var.ENVIRONMENT}-custom_public_route_table"
  }
}



# Route table for Private subnets
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.custom_nat_gtw.id
  }

  tags = {
    Name = "${var.ENVIRONMENT}-custom_private_route_table"
  }
}

# Route Table association with public subnets
resource "aws_route_table_association" "to_public_subnet1" {
  subnet_id      = aws_subnet.custom_vpc_public_subnet_1.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "to_public_subnet2" {
  subnet_id      = aws_subnet.custom_vpc_public_subnet_2.id
  route_table_id = aws_route_table.rt_public.id
}

# Route Table association with private subnets

resource "aws_route_table_association" "to_private_subnet1" {
  subnet_id      = aws_subnet.custom_vpc_private_subnet_1.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "to_private_subnet2" {
  subnet_id      = aws_subnet.custom_vpc_private_subnet_2.id
  route_table_id = aws_route_table.rt_private.id
}

#Output Specific to Custom VPC
output "my_vpc_id" {
  description = "VPC ID"
  value = aws_vpc.custom_vpc.id
}

output "public_subnet1_id" {
  description = "Subnet ID"
  value = aws_subnet.custom_vpc_public_subnet_1.id
}

output "public_subnet2_id" {
  description = "Subnet ID"
  value = aws_subnet.custom_vpc_public_subnet_2.id
}

output "private_subnet1_id" {
  description = "Subnet ID"
  value = aws_subnet.custom_vpc_private_subnet_1.id
}

output "private_subnet2_id" {
  description = "Subnet ID"
  value = aws_subnet.custom_vpc_private_subnet_2
}