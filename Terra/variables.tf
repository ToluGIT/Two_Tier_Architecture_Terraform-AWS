variable "vpc-cidr-block" {
  description = "CIDR Block for VPC"
}

variable "vpc-name" {
  description = "Name for Virtual Private Cloud"
}

variable "igw-name" {
  description = "Name for Internet Gateway"
}

variable "web-subnet1-cidr" {
  description = "CIDR Block for Web-tier Subnet-1"
}

variable "web-subnet1-name" {
  description = "Name for Web-tier Subnet-1"
}

variable "web-subnet2-cidr" {
  description = "CIDR Block for Web-tier Subnet-2"
}

variable "web-subnet2-name" {
  description = "Name for Web-tier Subnet-2"
}

variable "az-1" {
  description = "Availabity Zone 1"
}

variable "az-2" {
  description = "Availabity Zone 2"
}

variable "ami_id" {
  description = "The AMI ID for EC2 instances in the ASG"
  type        = string
}

variable "instance_type" {
  description = "The instance type for EC2 instances in the ASG"
  type        = string
  default     = "t2.micro" # Optional default value
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 4
}

variable "volume_type" {
  description = "The Volume type for EC2 instances (EBS) in the ASG"
  type        = string
}

variable "volume_size" {
  description = "Volume size of EC2 instances (EBS) in the ASG"
  type        = number
  default     = 20
}

variable "device_name" {
  description = "The device name for EC2 instances (EBS) in the ASG"
  type        = string
}
