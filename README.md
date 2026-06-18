<img width="100%" height="300" alt="Image" src="https://github.com/user-attachments/assets/827c4edb-07e0-4de1-8ec5-8ec335b6e366" />

# AWS Multi-Region Pilot Light Disaster Recovery with Terraform

## Project Overview

<p> This project demonstrates a multi-region Pilot Light Disaster Recovery solution built on AWS using Terraform. Route 53 health checks monitor the primary application, CloudWatch alarms detect failures, SNS sends notifications, and Lambda automatically starts a disaster recovery EC2 instance in a secondary region. </p>

## Architecture

<img width="100%" height="929" alt="Image" src="https://github.com/user-attachments/assets/70a666c6-ca03-48cc-9339-d06b383560b0" />

## Tech Stack

- Amazon EC2
- Amazon VPC (Security Groups,Internet Gateway)
- Route 53 Failover
- Route 53 Health Check 
- CloudWatch 
- SNS
- Lambda
- IAM
- Systems Manager (SSM)
- Terraform


## Failover Workflow

1. Route 53 monitors Primary EC2
2. Route 53 Health Check for primary EC2 fails
3. CloudWatch Alarm triggers
4. SNS sends email notification
5. SNS invokes Lambda
6. Lambda starts DR EC2
7. Route 53 redirects traffic to secondary EC2


## Project structure

```
infrastructure/
├── backend.tf (state locking)
├── compute.tf
├── iam.tf
├── lambda.tf
├── monitoring.tf
├── network.tf
├── providers.tf
├── route53.tf
├── security.tf
├── variables.tf
└── outputs.tf

lambda/
└── lambda_function.py

```

## Deployment

### Clone Repository

``` bash 
git clone <repo-url>

cd  infrastructure 

```

### Initialize Terraform

``` bash 

terrafrom init 

```

### Review Changes
```bash 
   terraform plan 
``` 

### Deploy Infrastructure

``` bash 
    terraform apply
```

## Future Improvements
