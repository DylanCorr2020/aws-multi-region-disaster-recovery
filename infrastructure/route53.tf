data "aws_route53_zone" "hosted_zone" {
  name         = "pilotlightdr.xyz"
  private_zone = false
}

resource "aws_route53_health_check" "health_check_eu_1a_pr" {
  ip_address        = aws_eip.eip_eu_west_1a_pr.public_ip
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  request_interval  = 30
  failure_threshold = 3

  tags = {
    Name = "health-check-eu-1a-pr"

  }

}




