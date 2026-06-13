output "project_summary" {
  description = "Pilot Light Disaster Recovery Architecture Summary"

  value = {
    domain_name      = "pilotlightdr.xyz"
    primary_region   = "eu-west-1"
    disaster_region  = "eu-west-2"
    failover_method  = "Route53 Failover Routing"
    recovery_method  = "Lambda Automation"
  }
}

# =====================
# EC2 Instances
# =====================

output "primary_instance_id" {
  description = "Primary EC2 Instance ID"
  value       = aws_instance.instance_eu_west_1a_pr.id
}

output "dr_instance_id" {
  description = "Disaster Recovery EC2 Instance ID"
  value       = aws_instance.instance_eu_west_2a_dr.id
}

output "primary_public_ip" {
  description = "Primary EC2 Elastic IP"
  value       = aws_eip.eip_eu_west_1a_pr.public_ip
}

output "dr_public_ip" {
  description = "Disaster Recovery EC2 Elastic IP"
  value       = aws_eip.eip_eu_west_2a_dr.public_ip
}

# =====================
# Route53
# =====================

output "route53_zone_id" {
  description = "Hosted Zone ID"
  value       = data.aws_route53_zone.hosted_zone.zone_id
}

output "health_check_id" {
  description = "Route53 Health Check ID"
  value       = aws_route53_health_check.health_check_instance_eu_west_1a_pr.id
}

# =====================
# Monitoring
# =====================

output "cloudwatch_alarm_name" {
  description = "CloudWatch Alarm Monitoring Health Check"
  value       = aws_cloudwatch_metric_alarm.healthcheck_status_eu_west_1a.alarm_name
}

output "sns_topic_arn" {
  description = "SNS Topic for DR Alerts"
  value       = aws_sns_topic.dr_failover_alerts.arn
}

# =====================
# Lambda
# =====================

output "lambda_function_name" {
  description = "Lambda Function Responsible For Starting DR Instance"
  value       = aws_lambda_function.ec2_start_lambda_function.function_name
}

