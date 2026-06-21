# ☁️ AWS Multi-Region Pilot Light Disaster Recovery (Terraform)

## 🚀 Overview

This project implements a **Pilot Light Disaster Recovery (DR) architecture on AWS using Terraform**.

A primary EC2 Instance runs in **eu-west-1 (Ireland)**, while a secondary EC2 Instance is deployed in **eu-west-2 (London)**.

The secondary EC2 instance is stopped to save costs.

In the event that the primary EC2 fails, automated monitoring and event-driven automation initiate failover, bringing the secondary EC2 online and redirecting traffic via **Amazon Route 53** to ensure there is no downtime for the application.

---

## 📘 Learn More

For a full breakdown of the architecture, challenges, and decisions, check out the Medium post:

👉 [Read the Case Study](https://medium.com/@dylancorr.g/building-a-multi-region-disaster-recovery-solution-on-aws-with-terraform-695a9c305dfb)

---

## 🏗️ Architecture

A full architecture diagram is included below:

<img width="100%" height="929" alt="Image" src="https://github.com/user-attachments/assets/e8b188d4-f1ff-4bde-969e-4b2757ffdea4" />

---

## 🔁 Failover Flow

1. Route 53 Health Check monitors the primary EC2 instance in eu-west-1.

2. The health check detects a failure and changes the status to unhealthy.

3. CloudWatch alarm enters the **ALARM** state when the Route 53 health check reports an unhealthy status.

4. SNS publishes a notification to admin when CloudWatch enters the **ALARM** state.

5. SNS invokes a Lambda function that uses Boto3 to start the secondary EC2 instance.

6. The standby EC2 instance is started in eu-west-2.

7. Route 53 routes traffic to the healthy EC2 Instance in region eu-west-2.

---

## 🧰 Tech Stack

### Compute

- Amazon EC2

### Networking

- Amazon VPC
- Internet Gateway
- Security Groups

### Traffic Management

- Amazon Route 53 (Health Checks & Failover Routing)

### Monitoring

- Amazon CloudWatch
- Amazon SNS

### Automation

- AWS Lambda

### Infrastructure as Code

- Terraform

---

## 📂 Project Structure

```
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

## ⚙️ Prerequisites

Before deployment, ensure you have the following:

- An AWS account with configured credentials (`aws configure` or environment variables)
- A Route 53-hosted domain
- An email address for SNS notifications
- Terraform >= 1.5 installed locally

---

## ⚙️ Configuration

Before deploying the infrastructure, ensure the following variables are updated:

- `alert_email` → Email address for SNS notifications (defined in `variables.tf`)
- `aws_route53_zone` → Your registered Route 53 hosted zone (defined in `variables.tf`)
- `backend S3 bucket` → Remote state storage bucket (defined in `backend.tf`)

---

## 🚀 Deployment

### 1. Clone the repository

```bash
git clone https://github.com/DylanCorr2020/aws-multi-region-disaster-recovery.git
cd infrastructure
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review the execution plan

```bash
terraform plan
```

### 4. Deploy infrastructure

```bash
terraform apply
```

## 🧪 Future Improvements

- Application Load Balancer (ALB) integration
- Auto Scaling Groups (ASGs) for dynamic capacity
- AWS Global Accelerator for improved failover routing
- Terraform module refactoring for scalability
- Automated failback mechanisms

---

## 👨‍💻 Author

Dylan Corr
