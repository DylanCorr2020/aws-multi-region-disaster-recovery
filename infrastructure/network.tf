# ====================== Create VPC for EU-WEST-1 ==============================

# Created a VPC with a public subnet and a route table that routes traffic to an internet gateway.

# Create VPC
resource "aws_vpc" "vpc_eu_west_1" {

  provider   = aws.euwest1
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-eu-west-1"
  }
}

# Public Subnet for eu-west-1a 
resource "aws_subnet" "public_s_eu_west_1a" {

  vpc_id                  = aws_vpc.vpc_eu_west_1.id
  provider                = aws.euwest1
  map_public_ip_on_launch = true
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  tags = {
    Name = "public-subnet-eu-west-1a"
  }
}

# Internet gateway for eu-west-1a
resource "aws_internet_gateway" "ig_eu_west_1" {
  vpc_id   = aws_vpc.vpc_eu_west_1.id
  provider = aws.euwest1
  tags = {
    Name = "internet_gateway_eu_west-1"
  }
}


#Public Route Table 
resource "aws_route_table" "public_rt_eu_west_1" {

  vpc_id   = aws_vpc.vpc_eu_west_1.id
  provider = aws.euwest1
  route {
    cidr_block = "0.0.0.0/0" #any ip address in public subnet routes to internet gateway
    gateway_id = aws_internet_gateway.ig_eu_west_1.id
  }

}

#Associate Public Subnet to Route Table 
resource "aws_route_table_association" "public_rt_association_eu_west_1" {

  subnet_id      = aws_subnet.public_s_eu_west_1a.id
  route_table_id = aws_route_table.public_rt_eu_west_1.id
  provider       = aws.euwest1
}



# ====================== Create VPC for EU-WEST-2 ==============================

# Created a VPC with a public subnet and a route table that routes traffic to an internet gateway.

# Create VPC
resource "aws_vpc" "vpc_eu_west_2" {

  provider   = aws.euwest2
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "vpc-eu-west-2"
  }
}

# Public Subnet for eu-west-2 
resource "aws_subnet" "public_s_eu_west_2a" {

  vpc_id                  = aws_vpc.vpc_eu_west_2.id
  provider                = aws.euwest2
  map_public_ip_on_launch = true
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "eu-west-2a"
  tags = {
    Name = "public-subnet-eu-west-2a"
  }
}

# Internet gateway for eu-west-1a
resource "aws_internet_gateway" "ig_eu_west_2" {
  vpc_id   = aws_vpc.vpc_eu_west_2.id
  provider = aws.euwest2
  tags = {
    Name = "internet-gateway-eu-west-2"
  }
}


#Public Route Table 
resource "aws_route_table" "public_rt_eu_west_2" {

  vpc_id   = aws_vpc.vpc_eu_west_2.id
  provider = aws.euwest2
  route {
    cidr_block = "0.0.0.0/0" #any ip address in public subnet routes to internet gateway
    gateway_id = aws_internet_gateway.ig_eu_west_2.id
  }

}

#Associate Public Subnet to Route Table 
resource "aws_route_table_association" "public_rt_association_eu_west_2" {

  provider       = aws.euwest2
  subnet_id      = aws_subnet.public_s_eu_west_2a.id
  route_table_id = aws_route_table.public_rt_eu_west_2.id
}
