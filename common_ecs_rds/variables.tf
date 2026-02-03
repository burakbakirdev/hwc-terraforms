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

# Security Group
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

# ECS
variable "ecs_name" {
  description = "ECS instance name suffix"
  type        = string
}

variable "ecs_flavor" {
  description = "ECS flavor (e.g., s6.large.2)"
  type        = string
}

variable "ecs_image_name" {
  description = "Image name for ECS (e.g., Ubuntu 24.04 server 64bit)"
  type        = string
}

variable "ecs_system_disk_type" {
  description = "System disk type (SAS, SSD, GPSSD)"
  type        = string
}

variable "ecs_system_disk_size" {
  description = "System disk size in GB"
  type        = number
}

variable "ecs_admin_pass" {
  description = "Admin password for ECS"
  type        = string
  sensitive   = true
}

# RDS
variable "rds_name" {
  description = "RDS instance name suffix"
  type        = string
}

variable "rds_flavor" {
  description = "RDS flavor (e.g., rds.mysql.n1.large.2)"
  type        = string
}

variable "rds_engine" {
  description = "RDS engine (MySQL, PostgreSQL, SQLServer)"
  type        = string
}

variable "rds_engine_version" {
  description = "RDS engine version"
  type        = string
}

variable "rds_volume_type" {
  description = "RDS volume type (ULTRAHIGH, HIGH, COMMON)"
  type        = string
}

variable "rds_volume_size" {
  description = "RDS volume size in GB"
  type        = number
}

variable "rds_password" {
  description = "RDS admin password"
  type        = string
  sensitive   = true
}

variable "rds_backup_start_time" {
  description = "RDS backup start time (HH:MM-HH:MM format)"
  type        = string
}

variable "rds_backup_keep_days" {
  description = "RDS backup retention days"
  type        = number
}

# Tags
variable "tags" {
  description = "Resource tags"
  type        = map(string)
}
