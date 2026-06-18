# ===============  Security Group for Primary EC2 Instance EU-WEST-1 ==============================

#Created a security group to allow inbound web traffic on port 80 and outbound internet access for installing the Apache web server.

# Create a security group 
resource "aws_security_group" "sg_eu_west_1_pr" {
  description = "Security group to allow traffic on ports"
  vpc_id      = aws_vpc.vpc_eu_west_1.id
  name        = "sg_eu_west_1_pr"
}


# Allow inbound traffic on port 80 
resource "aws_vpc_security_group_ingress_rule" "http_eu_west_1_pr" {
  security_group_id = aws_security_group.sg_eu_west_1_pr.id
  cidr_ipv4         = "0.0.0.0/0" # Allow from anywhere (public access)
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Allow any machine to ping ec2 instance 
resource "aws_vpc_security_group_ingress_rule" "icmp_eu_west_1_pr" {
  security_group_id = aws_security_group.sg_eu_west_1_pr.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"

}



# Allow ALL outbound traffic to connect to the internet install apache web server 
resource "aws_vpc_security_group_egress_rule" "all_outbound_eu_west_1_pr" {
  security_group_id = aws_security_group.sg_eu_west_1_pr.id
  cidr_ipv4         = "0.0.0.0/0" # Allow from anywhere (public access)
  ip_protocol       = "-1"        #any protocal
}


# ===============  Security Group for Disaster Recovery EC2 Instance EU-WEST-2 ==============================

# Create a security group 
resource "aws_security_group" "sg_eu_west_2_dr" {
  description = "Security group to allow traffic on ports"
  vpc_id      = aws_vpc.vpc_eu_west_2.id
  provider    = aws.euwest2
  name        = "SG-eu-west-2-dr"
}


# Allow inbound traffic on port 80 
resource "aws_vpc_security_group_ingress_rule" "http_eu_west_2_dr" {
  security_group_id = aws_security_group.sg_eu_west_2_dr.id
  provider          = aws.euwest2
  cidr_ipv4         = "0.0.0.0/0" # Allow from anywhere (public access)
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Allow any machine to ping ec2 instance 
resource "aws_vpc_security_group_ingress_rule" "icmp_eu_west_2_dr" {
  security_group_id = aws_security_group.sg_eu_west_2_dr.id
  provider          = aws.euwest2
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"

}



# Allow ALL outbound traffic to connect to the internet install apache web server 
resource "aws_vpc_security_group_egress_rule" "all_outbound_eu_west_2_dr" {
  security_group_id = aws_security_group.sg_eu_west_2_dr.id
  provider          = aws.euwest2
  cidr_ipv4         = "0.0.0.0/0" # Allow from anywhere (public access)
  ip_protocol       = "-1"        #any protocal
}
