# Provider
variable "region" {
  description = "Huawei Cloud region"
  type        = string
}

variable "access_key" {
  description = "Huawei Cloud access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Huawei Cloud secret key"
  type        = string
  sensitive   = true
}

variable "enterprise_project_id" {
  description = "Enterprise project ID (optional)"
  type        = string
  default     = ""
}

# Project
variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

# VPC
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

# Subnets
variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name              = string
    cidr              = string
    gateway_ip        = string
    availability_zone = string
  }))
}

# EIP
variable "create_eip" {
  description = "Create Elastic IP"
  type        = bool
}

variable "eip_bandwidth_size" {
  description = "EIP bandwidth (Mbit/s)"
  type        = number
}

variable "eip_bandwidth_share_type" {
  description = "Bandwidth type: PER (dedicated) or WHOLE (shared)"
  type        = string
}

# Security Group
variable "remote_ip" {
  description = "Allowed source IP for SSH access"
  type        = string
}

variable "security_group_rules" {
  description = "Security group rules"
  type = list(object({
    description      = string
    direction        = string
    ethertype        = string
    protocol         = string
    port_range_min   = number
    port_range_max   = number
    remote_ip_prefix = string
  }))
}

# NAT Gateway
variable "create_nat_gateway" {
  description = "Create NAT Gateway"
  type        = bool
}

variable "nat_gateway_spec" {
  description = "NAT spec: 1=Small, 2=Medium, 3=Large, 4=XLarge"
  type        = string
}

# Tags
variable "tags" {
  description = "Resource tags"
  type        = map(string)
}
