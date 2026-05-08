

# ====================== Create VPC for EU-WEST-1 ==============================

# Created a VPC with a public subnet and a route table that routes traffic to an internet gateway.

# Create VPC
resource "aws_vpc" "vpc-eu-west-1" {

  provider   = aws.euwest1
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-eu-west-1"
  }
}

# Public Subnet for eu-west-1a 
resource "aws_subnet" "public-s-eu-west-1" {

  vpc_id     = aws_vpc.vpc-eu-west-1.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public-subnet-eu-west-1"
  }
}

# Internet gateway for eu-west-1a
resource "aws_internet_gateway" "ig-euwest-1" {
  vpc_id = aws_vpc.vpc-eu-west-1.id
  tags = {
    Name = "internet_gateway_euwest1"
  }
}


#Public Route Table 
resource "aws_route_table" "public-rt-eu-west1-1" {

  vpc_id = aws_vpc.vpc-eu-west-1.id

  route {
    cidr_block = "0.0.0.0/0" #any ip address in public subnet routes to internet gateway
    gateway_id = aws_internet_gateway.ig-euwest-1.id
  }

}

#Attach Public Subnet to Route Table 
resource "aws_route_table_association" "public-rt-association-eu-west-1" {

  subnet_id      = aws_subnet.public-s-eu-west-1.id
  route_table_id = aws_route_table.public-rt-eu-west1-1.id
}



# ====================== Create VPC for EU-WEST-2 ==============================

