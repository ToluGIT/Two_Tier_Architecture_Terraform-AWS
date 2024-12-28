# AWS High Availability Infrastructure with Terraform

An Infrastructure as Code (IaC) implementation using Terraform to deploy a tier-1 highly available web applications on AWS with automated CI/CD and security scanning.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Security Features](#security-features)
- [Installation](#installation)
- [Infrastructure Components](#infrastructure-components)
- [CI/CD Pipeline](#cicd-pipeline)
- [Security and Code Quality](#security-and-code-quality)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)

## Overview

This project provides Infrastructure as Code for deploying a highly available web application infrastructure on AWS using Terraform. It includes automated deployment through GitHub Actions, security scanning, and infrastructure best practices.

### Architecture Diagram

![Tier1 High Av  aws environment](https://github.com/user-attachments/assets/1c52cee2-3188-484f-a34e-eaf4d2e46c64)


## Features

- Multi-AZ deployment for high availability
- Auto-scaling with customizable thresholds
- Application Load Balancer with health checks
- Secure instance management via AWS Systems Manager
- Security scanning
- Automated CI/CD pipeline using GitHub Actions
- State management with S3 backend and DynamoDB locking
- Pre-commit hooks for code quality
- Optional WAF integration

## Prerequisites

### Required Tools
- Terraform >= 1.9.8
- AWS CLI >= 2.0
- Git >= 2.28
- Python >= 3.8 (for pre-commit hooks)
- VS Code (recommended) or preferred IDE
- Basic understanding of AWS services and Terraform


### AWS Requirements
- AWS Account with administrative access
- S3 bucket for Terraform state
- DynamoDB table for state locking
- IAM role for GitHub Actions
  

## Security Features

### Infrastructure Security
- VPC isolation with proper subnet segregation
- Least privilege security group rules
- IAM roles with minimal permissions
- Systems Manager for secure instance access
- EBS volume encryption
- TLS termination at ALB
- State file encryption
- Secret scanning in CI/CD

### Pre-commit Security Checks

```yaml
repos:
  - repo: https://github.com/bridgecrewio/checkov
    rev: 3.2.305
    hooks:
      - id: checkov
        args: ["--quiet"]

  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.96.1
    hooks:
      - id: terraform_fmt
      - id: terraform_validate
      - id: terraform_tflint
      - id: terraform_docs

  - repo: https://github.com/aquasecurity/tfsec
    rev: v1.28.10
    hooks:
      - id: tfsec

  - repo: https://github.com/zricethezav/gitleaks
    rev: v8.8.4
    hooks:
      - id: gitleaks
```

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Install pre-commit hooks:
```bash
pip install pre-commit
pre-commit install
```

3. Configure AWS credentials:
```bash
aws configure
# Or set environment variables:
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_REGION="us-east-1"
```

4. Initialize Terraform:
```bash
terraform init
```

5. Configure variables:
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

## Infrastructure Components

### VPC and Network
- VPC with CIDR: 10.0.0.0/16
- Public Subnets:
  - AZ-1: 10.0.1.0/24 (us-east-1a)
  - AZ-2: 10.0.2.0/24 (us-east-1b)
- Internet Gateway
- Route tables for internet access

### Load Balancer
- Application Load Balancer (ALB)
- Health checks on port 80
- Target group with HTTP protocol
- Security group for HTTP traffic

### Auto Scaling Group
- Launch template with Amazon Linux 2
- Min: 1, Desired: 2, Max: 4 instances
- Health check grace period: 300s
- Multi-AZ deployment

## CI/CD Pipeline

### GitHub Actions Workflow

1. AWS Authentication:
```yaml
- name: Configure AWS Credentials
  uses: aws-actions/configure-aws-credentials@v4
  with:
    role-to-assume: ${{ secrets.ROLE_TO_ASSUME }}
    aws-region: ${{ secrets.AWS_REGION }}
    audience: sts.amazonaws.com
```

2. Security Scanning:
```yaml
- name: Run Checkov
  uses: bridgecrewio/checkov-action@v12
  with:
    directory: ${{ env.TERRAFORM_DIRECTORY }}
    output_format: cli,sarif
```

3. Infrastructure Deployment:
```yaml
- name: Terraform Apply
  if: github.event_name == 'push'
  run: terraform apply -auto-approve tfplan
```

### Required GitHub Secrets
- `ROLE_TO_ASSUME`: AWS IAM role ARN
- `AWS_REGION`: Target AWS region

## Security and Code Quality

### Pre-commit Hooks
- Checkov for security scanning
- Terraform formatting and validation
- TFLint for Terraform linting
- TFSec for security best practices
- Gitleaks for secret scanning

### Infrastructure Security
- Network segmentation
- Security group rules
- IAM least privilege
- Encryption at rest
- Secure instance access

## Configuration

### Terraform State Management
- Backend: S3 with encryption
- State locking: DynamoDB
- Workspace support

### Variable Management
```hcl
# terraform.tfvars
vpc-cidr-block   = "10.0.0.0/16"
vpc-name         = "vpc-high-available"
igw-name         = "igw-high-available"
web-subnet1-cidr = "10.0.1.0/24"
web-subnet2-cidr = "10.0.2.0/24"
instance_type    = "t2.micro"
```

## Troubleshooting

### Common Issues

1. Terraform State Lock Issues:
```bash
# Remove state lock
aws dynamodb delete-item \
    --table-name terraform-lock-table \
    --key '{"LockID": {"S": "terraform-state"}}'
```

2. ASG Instance Launch Failures:
- Check launch template configuration
- Verify AMI availability
- Review security group rules
- Check instance profile permissions

3. ALB Health Check Failures:
- Verify security group rules
- Check instance health status
- Review target group settings
- Validate EC2 user data script

### Debugging Tools
- AWS Systems Manager Session Manager
- CloudWatch Logs
- ALB Access Logs
- VPC Flow Logs

