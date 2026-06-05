
## Create Role to SSM into EC2 Instances 

resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name
}


## Create IAM Role for Lambda 

resource "aws_iam_role" "ec2_start_lambda_role" {

  name = "ec2_start_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })

}


// Create custom policy for Lambda 

resource "aws_iam_role_policy" "my_ec2_start_policy" {

  name = "ec2_start_policy"
  role = aws_iam_role.ec2_start_lambda_role.name

  policy = jsonencode({
    Version : "2012-10-17",
    Statement = [{
      Action = [
        "logs:CreateLogStream",
        "ec2:StartInstances",
        "ec2:StopInstances",
        "logs:CreateLogGroup",
        "logs:PutLogEvents",

      ]
      Effect    = "Allow"
      Resource = "*"
    }]
  })
}
