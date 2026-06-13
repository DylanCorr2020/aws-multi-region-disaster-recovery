
// Create the lambda Function 

// Create Lambda Function 
resource "aws_lambda_function" "ec2_start_lambda_function" {

  function_name = "ec2-start-lambda-function"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  role          = aws_iam_role.ec2_start_lambda_role.arn
  filename      = "lambda.zip"
  provider      = aws.useast1
  timeout       = 30

  #Terraform to detect changes when the zip updates
  #source_code_hash = filebase64sha256("lambda.zip")

  environment {
    variables = {
      DR_INSTANCE_ID = aws_instance.instance_eu_west_2a_dr.id
    }
  }

}



# Permission for SNS to invoke Lambda
resource "aws_lambda_permission" "sns_invoke" {
  statement_id  = "AllowSNSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_start_lambda_function.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.dr_failover_alerts.arn
  provider      = aws.useast1
}
