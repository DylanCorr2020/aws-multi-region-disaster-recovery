
#reference hosted zone 
data "aws_route53_zone" "hosted_zone" {
  name         = "pilotlightdr.xyz"
  private_zone = false
}


#Create health check for ec2-instance-1a-pr 
resource "aws_route53_health_check" "health_check_instance_eu_west_1a_pr" {
  ip_address        = aws_eip.eip_eu_west_1a_pr.public_ip
  provider          = aws.useast1
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  request_interval  = 30
  failure_threshold = 3

  tags = {
    Name = "health-check-instance-eu-west-1a-pr"

  }

}

#Create DNS failover record for primary ec2 
resource "aws_route53_record" "primary_ec2_record" {
  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = "pilotlightdr.xyz"
  type    = "A"
  ttl     = 60
  records = [aws_eip.eip_eu_west_1a_pr.public_ip]

  failover_routing_policy {
    type = "PRIMARY"
  }

  set_identifier = "primary"


  health_check_id = aws_route53_health_check.health_check_instance_eu_west_1a_pr.id

}


#Create DNS failover record for secondary ec2 
resource "aws_route53_record" "secondary_ec2_record" {
  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = "pilotlightdr.xyz"
  type    = "A"
  ttl     = 60
  records = [aws_eip.eip_eu_west_2a_dr.public_ip]
  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier = "secondary"
}



