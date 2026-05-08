


# ====================== Create Primary EC2 Instance for EU-WEST-1 ==============================


resource "aws_instance" "instance-eu-west-1a-pr" {

  instance_type = "t2.micro"
  ami           = "ami-0de864d6a3bd20ea8" #ubuntu

  associate_public_ip_address = true

  subnet_id = aws_subnet.public-s-eu-west-1.id

  vpc_security_group_ids = [aws_security_group.SG-eu-west-1.id]

  #Attach SSM policy 
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  #User data script to install apache web server on boot 
  #user_data = <<-EOF
                #!/bin/bash
                #apt update -y
                #apt install httpd -y
                #systemctl start httpd
                #systemctl enable httpd
                #echo "instance-eu-west-1a-pr" > /var/www/html/index.html
                #EOF

  tags = {

    Name = "instance-eu-west-1a-pr"

  }

}






