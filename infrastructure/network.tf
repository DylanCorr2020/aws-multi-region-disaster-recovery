# Create VPC for eu-west-1

resource "aws_vpc" "vpc-eu-west-1" {

  provider   = aws.euwest1
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-eu-west-1"
  }
}

# Public Subnet 
resource "aws_subnet" "public-subnet-eu-west-1" {

  vpc_id     = aws_vpc.vpc-eu-west-1.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public-subnet-eu-west-1"
  }
}

# Internet gateway 
resource "aws_internet_gateway" "internet_gateway_euwest1" {
  vpc_id = aws_vpc.vpc-eu-west-1.id
  tags = {
    Name = "internet_gateway_euwest1"
  }
}


#Public Route Table 
resource "aws_route_table" "public-route-table-euwest1a" {

  vpc_id = aws_vpc.vpc-eu-west-1.id

  route {
    cidr_block = "0.0.0.0/0" #any ip address
    gateway_id = aws_internet_gateway.internet_gateway_euwest1.id
  }

}

#Route Table Assosiation 

resource "aws_route_table_association" "public-RT-association-euwest1a" {

  subnet_id      = aws_subnet.public-subnet-eu-west-1.id
  route_table_id = aws_route_table.public-route-table-euwest1a.id
}



