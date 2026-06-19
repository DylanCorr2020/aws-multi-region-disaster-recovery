# AWS Multi-Region Pilot Light Disaster Recovery with Terraform

<img width="100%" height="500" alt="Image" src="https://github.com/user-attachments/assets/827c4edb-07e0-4de1-8ec5-8ec335b6e366" />


## Project Overview

This project demonstrates a multi-region Pilot Light Disaster Recovery solution built on AWS using Terraform.

The primary application runs on an EC2 instance in the eu-west-1 (Ireland) region. A secondary EC2 instance is deployed in eu-west-2 (London) and remains stopped during normal operation to reduce costs.

Amazon Route 53 health checks monitor the primary application. When a failure is detected, CloudWatch triggers an alarm, SNS sends an email notification, and Lambda automatically starts the disaster recovery EC2 instance. Route 53 then redirects traffic to the healthy environment.

## Full Project Walkthrough

A detailed breakdown of the architecture, implementation, troubleshooting process, and failover testing can be found in the accompanying Medium article.

**Medium Article:** *(Add link here once published)*

---

## Architecture

The following diagram illustrates the failover workflow and AWS services used in the solution.

<img width="100%" height="929" alt="Image" src="https://github.com/user-attachments/assets/70a666c6-ca03-48cc-9339-d06b383560b0" />

---

## Tech Stack

- Terraform
- Amazon EC2
- Amazon VPC
- Security Groups
- Internet Gateway
- Route 53 Failover Routing
- Route 53 Health Checks
- Amazon CloudWatch
- Amazon SNS
- AWS Lambda
- AWS IAM
- AWS Systems Manager (SSM)

---


## Failover Workflow

1. Route 53 monitors the primary EC2 instance using a health check
2. The primary application becomes unavailable
3. Route 53 health check detects the failure
4. CloudWatch transitions into the ALARM state
5. SNS sends an email notification
6. SNS invokes a Lambda function
7. Lambda starts the disaster recovery EC2 instance
8. Route 53 redirects traffic to the secondary environment

---

## Project Structure

```text
infrastructure/
├── backend.tf
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

---

## Prerequisites

Before deploying the solution, ensure the following requirements are met:

- AWS account
- AWS credentials configured locally
- Registered Route 53 domain name
- Valid email address for SNS notifications
- Terraform installed
- Update Route 53 domain variables in `variables.tf`
- Update the SNS notification email address in `variables.tf`
- Configure Terraform backend settings if using remote state

---

## Deployment

### Clone Repository

```bash
git clone <repository-url>

cd infrastructure
```

### Initialize Terraform

```bash
terraform init
```

### Review Planned Changes

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

### Destroy Infrastructure

```bash
terraform destroy
```

---

## Future Improvements

- Auto Scaling Groups (ASGs)
- Application Load Balancer (ALB)
- AWS Global Accelerator
- Terraform Modules
- Automated Failback

---

## Author

Created as a hands-on AWS Disaster Recovery project to demonstrate:

- Multi-region architecture design
- Infrastructure as Code (Terraform)
- AWS monitoring and alerting
- Serverless automation with Lambda
- Disaster Recovery best practices