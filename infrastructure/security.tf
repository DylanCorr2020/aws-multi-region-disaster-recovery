# ===============  Security Group for Primary EC2 Instance EU-WEST-1 ==============================

# Create a security group 
resource "aws_security_group" "SG-eu-west-1" {
  description = "Security group to allow traffic on ports"
  vpc_id      = aws_vpc.vpc-eu-west-1.id
  name        = "SG-eu-west-1"
}


# Allow inbound traffic on port 80 
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.SG-eu-west-1.id
  cidr_ipv4         = "0.0.0.0/0" # Allow from anywhere (public access)
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Allow any machine to ping ec2 instance 
resource "aws_vpc_security_group_ingress_rule" "icmp" {
  security_group_id = aws_security_group.SG-eu-west-1.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = -1
  to_port = -1
  ip_protocol = "icmp"
  
}



# Allow ALL outbound traffic to connect to the internet install apache web server 
resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.SG-eu-west-1.id
  cidr_ipv4         = "0.0.0.0/0" # Allow from anywhere (public access)
  ip_protocol       = "-1" #any protocal
}


