# ☁️ AWS Multi-Region Pilot Light Disaster Recovery (Terraform)

## 🚀 Overview

This project implements a **Pilot Light Disaster Recovery (DR) architecture on AWS using Terraform**.

A production workload runs in **eu-west-1 (Ireland)**, while a minimal standby environment is deployed in **eu-west-2 (London)**. The secondary region remains in a scaled-down state under normal operation to optimize cost.

In the event of a regional failure, automated monitoring and event-driven automation initiate failover, bringing the standby environment online and redirecting traffic via **Amazon Route 53**.

---

## 🤔 Why Pilot Light?

A Pilot Light strategy was chosen to balance **cost efficiency** and **recovery speed**.

Only essential infrastructure components are kept running in the secondary region, allowing rapid scaling during failover while avoiding the cost of fully duplicated environments.

---

## 📘 Learn More

For a full breakdown of the architecture, challenges, and decisions, check out the Medium post:

👉 [Read the Case Study](https://medium.com/@dylancorr.g/building-a-multi-region-disaster-recovery-solution-on-aws-with-terraform-695a9c305dfb)

---

## 🏗️ Architecture

The solution is built around AWS-native observability and automation services:

- **Route 53** health checks continuously monitor the primary region
- **CloudWatch** alarms detect service degradation or failure
- **SNS** triggers notifications and event fan-out
- **AWS Lambda** orchestrates recovery actions
- **EC2** instances in the secondary region are started on demand

A full architecture diagram is included below:

<img width="100%" height="929" alt="Image" src="https://github.com/user-attachments/assets/e8b188d4-f1ff-4bde-969e-4b2757ffdea4" />

---

## 🔁 Failover Flow

1. Route 53 continuously monitors the primary endpoint
2. Health check failure is detected
3. CloudWatch alarm enters **ALARM** state
4. SNS publishes a notification event
5. Lambda function is invoked
6. Standby EC2 instance is started in eu-west-2
7. Route 53 routes traffic to the healthy region

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

### Observability

- Amazon CloudWatch
- Amazon SNS

### Automation

- AWS Lambda
- AWS Systems Manager (SSM)
- AWS IAM

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

Before deployment, ensure you have:

- An AWS account with configured credentials (`aws configure` or environment variables)
- A Route 53-hosted domain
- An email address for SNS notifications
- Terraform >= 1.5 installed locally

---

## 🚀 Deployment

### 1. Clone the repository

```bash
git clone <repository-url>
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

### ⚠️ Destroy infrastructure

```bash
terraform destroy
```

> Warning: This will permanently delete all deployed resources.

---

## 🧪 Future Improvements

- Application Load Balancer (ALB) integration
- Auto Scaling Groups (ASGs) for dynamic capacity
- AWS Global Accelerator for improved failover routing
- Terraform module refactoring for scalability
- Automated failback mechanisms

---

## 👨‍💻 Author

Built as a hands-on cloud engineering project demonstrating:

- Multi-region AWS architecture design
- Infrastructure as Code with Terraform
- Event-driven automation with AWS Lambda
- Cloud monitoring and failover strategies
- Production-style disaster recovery patterns
