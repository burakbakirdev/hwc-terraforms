# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = huaweicloud_vpc.main.id
}

# Subnets
output "subnet_ids" {
  description = "Subnet IDs"
  value       = { for k, v in huaweicloud_vpc_subnet.subnets : k => v.id }
}

# Security Group
output "security_group_id" {
  description = "Security group ID"
  value       = huaweicloud_networking_secgroup.main.id
}

# ECS
output "ecs_id" {
  description = "ECS instance ID"
  value       = huaweicloud_compute_instance.main.id
}

output "ecs_name" {
  description = "ECS instance name"
  value       = huaweicloud_compute_instance.main.name
}

output "ecs_private_ip" {
  description = "ECS private IP address"
  value       = huaweicloud_compute_instance.main.access_ip_v4
}

# RDS
output "rds_id" {
  description = "RDS instance ID"
  value       = huaweicloud_rds_instance.main.id
}

output "rds_name" {
  description = "RDS instance name"
  value       = huaweicloud_rds_instance.main.name
}

output "rds_private_ips" {
  description = "RDS private IP addresses"
  value       = huaweicloud_rds_instance.main.private_ips
}
