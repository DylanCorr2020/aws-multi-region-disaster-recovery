
#Create SNS topic 
resource "aws_sns_topic" "dr_failover_alerts" {
  name     = "dr-failover-alerts"
  provider = aws.useast1

}

#Create subscription for email 
resource "aws_sns_topic_subscription" "dr_failover_email_alert" {
  topic_arn = aws_sns_topic.dr_failover_alerts.arn
  protocol  = "email"
  endpoint  = "dylancorr.g@gmail.com"
  provider  = aws.useast1

}

# SNS subscription - Lambda subscribes to the topic
resource "aws_sns_topic_subscription" "dr_failover_lambda_alert" {
  topic_arn = aws_sns_topic.dr_failover_alerts.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.ec2_start_lambda_function.arn
  provider = aws.useast1
}

#Every 60 seconds, check Route 53 health status for this endpoint.
#If it is 0 (unhealthy) even once, immediately send an SNS email alert.
resource "aws_cloudwatch_metric_alarm" "healthcheck_status_eu_west_1a" {

  provider = aws.useast1

  alarm_name          = "healthcheck-status-eu-west-1a"
  comparison_operator = "LessThanThreshold"
  threshold           = 1         #value comparing against 
  evaluation_periods  = 1         #How many periods must fail before alarm triggers
  period              = 60        #look at metric every 60 seconds 
  statistic           = "Minimum" #if ANY check is unhealthy alarm triggers

  namespace   = "AWS/Route53"
  metric_name = "HealthCheckStatus"

  # Reference instance id of health check 
  dimensions = {
    HealthCheckId = aws_route53_health_check.health_check_instance_eu_west_1a_pr.id
  }

  #when alarm goes to "ALARM" state send notification to SNS topic
  alarm_actions = [
    aws_sns_topic.dr_failover_alerts.arn
  ]

  treat_missing_data = "breaching"
}

