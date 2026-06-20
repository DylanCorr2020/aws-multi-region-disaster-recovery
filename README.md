# AWS Multi-Region Pilot Light Disaster Recovery (Terraform) ☁️

## Overview

This project implements a **Pilot Light Disaster Recovery architecture** on AWS using Terraform.

A primary application runs in **eu-west-1 (Ireland)**, while a minimal standby environment is deployed in **eu-west-2 (London)**. The secondary region remains powered off under normal operation to reduce cost.

In the event of a failure, automated monitoring triggers a failover process that starts the standby infrastructure and redirects traffic using Route 53.

## Full Project Walkthrough 📘

A detailed breakdown of the architecture, implementation, troubleshooting process, and failover testing can be found in the accompanying Medium article.

**Medium Article:** _(https://medium.com/@dylancorr.g/building-a-multi-region-disaster-recovery-solution-on-aws-with-terraform-695a9c305dfb)_

---

## Architecture 🏗️

The solution uses Route 53 health checks, CloudWatch alarms, SNS notifications, and Lambda automation to orchestrate failover between regions.

<img width="100%" height="929" alt="Image" src="https://github.com/user-attachments/assets/70a666c6-ca03-48cc-9339-d06b383560b0" />

---

## Tech Stack 🧰

### Compute

- Amazon EC2

### Networking

- Amazon VPC
- Internet Gateway
- Security Groups
- Route 53 (Failover Routing + Health Checks)

### Observability

- Amazon CloudWatch
- Amazon SNS

### Automation

- AWS Lambda
- AWS IAM
- AWS Systems Manager (SSM)

### Infrastructure as Code

- Terraform

---

## Failover Flow 🔁

1. Route 53 continuously monitors the primary endpoint
2. Health check failure is detected
3. CloudWatch alarm enters **ALARM** state
4. SNS sends an email notification
5. SNS triggers a Lambda function
6. Lambda starts the standby EC2 instance in eu-west-2
7. Route 53 routes traffic to the healthy region

---

## Project Structure 📂

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

## Prerequisites ✅

- AWS account with credentials configured
- Registered Route 53 domain
- Email address for SNS notifications
- Terraform installed locally

## Configuration Notes ⚙️

- Route 53 domain variables in variables.tf
- SNS notification email in variables.tf
- Terraform backend configuration (if using remote state)

## Deployment 🚀

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

## Author 👨‍💻

Built as a hands-on AWS Disaster Recovery project demonstrating:

- Multi-region architecture design
- Infrastructure as Code with Terraform
- Automated monitoring and failover
- Serverless recovery orchestration
- AWS disaster recovery best practices
