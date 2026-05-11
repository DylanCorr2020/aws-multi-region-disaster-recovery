


# ====================== Create Primary EC2 Instance for EU-WEST-1 ==============================
resource "aws_instance" "instance_eu_west_1a_pr" {

  instance_type = "t2.micro"
  ami           = "ami-0de864d6a3bd20ea8" #ubuntu

  #associate_public_ip_address = true

  subnet_id = aws_subnet.public_s_eu_west_1a.id

  vpc_security_group_ids = [aws_security_group.sg_eu_west_1_pr.id]

  #Attach SSM policy 
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
               #!/bin/bash
               apt-get update -y
               apt-get install apache2 -y
               echo "<h1> Welcome to my primary EC2 eu-west-1a </h1>" > /var/www/html/index.html
               sudo systemctl start apache2
               EOF
  tags = {

    Name = "instance-eu-west-1a-pr"

  }
}


# ====================== Create Disaster Recovery EC2 Instance for EU-WEST-2 ==============================


resource "aws_instance" "instance_eu_west_2a_dr" {

  instance_type = "t2.micro"
  ami           = "ami-0de864d6a3bd20ea8" #ubuntu

  #associate_public_ip_address = true

  subnet_id = aws_subnet.public_s_eu_west_2a.id

  vpc_security_group_ids = [aws_security_group.sg_eu_west_2_dr.id]

  #Attach SSM policy 
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
               #!/bin/bash
               apt-get update -y
               apt-get install apache2 -y
               echo "<h1>Welcome to my disaster recovery EC2 eu-west-2a </h1>" > /var/www/html/index.html
               sudo systemctl start apache2
               EOF
  tags = {

    Name = "instance-eu-west-2a-dr"

  }
}


