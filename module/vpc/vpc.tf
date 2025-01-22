data "aws_availability_zones" "available" {
  state = "available"
}

# Main vpc
resource "aws_vpc" "custom_vpc" {
    cidr_block = var.CUSTOM_VPC_CIDR_BLOCK
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = "${var.ENVIRONMENT}-vpc" 
    }
}

#Public subnets
# public Sunbet 1
resource "aws_subnet" "custom_vpc_public_subnet_1" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.CUSTOM_VPC_PUBLIC_SUBNET1_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

     tags = {
      Name = "${var.ENVIRONMENT}_custom_vpc_public_subnet_1" 
    }
}

# public Sunbet 2
resource "aws_subnet" "custom_vpc_public_subnet_2" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.CUSTOM_VPC_PUBLIC_SUBNET2_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

     tags = {
      Name = "${var.ENVIRONMENT}_custom_vpc_public_subnet_2" 
    }
}

# private Sunbet 1
resource "aws_subnet" "custom_vpc_private_subnet_1" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.CUSTOM_VPC_PRIVATE_SUBNET1_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

     tags = {
      Name = "${var.ENVIRONMENT}_custom_vpc_private_subnet_1" 
    }
}

# private Sunbet 2
resource "aws_subnet" "custom_vpc_private_subnet_2" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.CUSTOM_VPC_PRIVATE_SUBNET2_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

     tags = {
      Name = "${var.ENVIRONMENT}_custom_vpc_private_subnet_2" 
    }
}