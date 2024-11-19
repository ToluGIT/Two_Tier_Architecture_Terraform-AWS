provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "terras3-state"           # Replace with your actual S3 bucket name
    key            = "terraform/state.tfstate" # Path to store the state file within the bucket
    region         = "us-east-1"               # Replace with your AWS region
    encrypt        = true                      # Enable server-side encryption
    dynamodb_table = "terraform-lock-table"    # Replace with your DynamoDB table name for state locking
  }
}