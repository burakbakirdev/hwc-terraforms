# Authentication via environment variables (recommended):
# $ export HW_ACCESS_KEY="anaccesskey"
# $ export HW_SECRET_KEY="asecretkey"
# $ export HW_REGION_NAME="tr-west-1"

# Provider
region     = "tr-west-1"
access_key = "YOUR_ACCESS_KEY"
secret_key = "YOUR_SECRET_KEY"

# Enterprise Project (optional)
# enterprise_project_id = "YOUR_ENTERPRISE_PROJECT_ID"

# Project
project_name = "ecsrds"
environment  = "dev"

# VPC
vpc_cidr = "10.1.0.0/16"

# Subnets
subnets = [
  {
    name              = "app"
    cidr              = "10.1.1.0/24"
    gateway_ip        = "10.1.1.1"
    availability_zone = "tr-west-1a"
  },
  {
    name              = "db"
    cidr              = "10.1.2.0/24"
    gateway_ip        = "10.1.2.1"
    availability_zone = "tr-west-1a"
  }
]

# Security Group Rules
security_group_rules = [
  {
    description      = "SSH"
    direction        = "ingress"
    ethertype        = "IPv4"
    protocol         = "tcp"
    port_range_min   = 22
    port_range_max   = 22
    remote_ip_prefix = "0.0.0.0/0"
  },
  {
    description      = "HTTP"
    direction        = "ingress"
    ethertype        = "IPv4"
    protocol         = "tcp"
    port_range_min   = 80
    port_range_max   = 80
    remote_ip_prefix = "0.0.0.0/0"
  },
  {
    description      = "HTTPS"
    direction        = "ingress"
    ethertype        = "IPv4"
    protocol         = "tcp"
    port_range_min   = 443
    port_range_max   = 443
    remote_ip_prefix = "0.0.0.0/0"
  },
  {
    description      = "MySQL"
    direction        = "ingress"
    ethertype        = "IPv4"
    protocol         = "tcp"
    port_range_min   = 3306
    port_range_max   = 3306
    remote_ip_prefix = "10.1.0.0/16"
  }
]

# ECS Configuration
ecs_name             = "web"
ecs_flavor           = "ac8.xlarge.2"
ecs_image_name       = "Ubuntu 24.04 server 64bit"
ecs_system_disk_type = "SSD"
ecs_system_disk_size = 40
ecs_admin_pass       = "<YOUR_ECS_PASSWORD>"

# RDS Configuration
rds_name              = "mysql"
rds_flavor            = "rds.mysql.n1.large.2"
rds_engine            = "MySQL"
rds_engine_version    = "8.0"
rds_volume_type       = "CLOUDSSD"
rds_volume_size       = 100
rds_password          = "<YOUR_RDS_PASSWORD>"
rds_backup_start_time = "02:00-03:00"
rds_backup_keep_days  = 7

# Tags
tags = {
  Team       = "your-team"
  CostCenter = "your-cost-center"
  Owner      = "your-name"
}
