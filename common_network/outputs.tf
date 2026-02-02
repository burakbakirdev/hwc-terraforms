# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = huaweicloud_vpc.main.id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = huaweicloud_vpc.main.cidr
}

# Subnets
output "subnet_ids" {
  description = "Subnet IDs"
  value       = { for k, v in huaweicloud_vpc_subnet.subnets : k => v.id }
}

output "subnet_cidrs" {
  description = "Subnet CIDRs"
  value       = { for k, v in huaweicloud_vpc_subnet.subnets : k => v.cidr }
}

# Security Group
output "security_group_id" {
  description = "Security group ID"
  value       = huaweicloud_networking_secgroup.main.id
}

output "security_group_name" {
  description = "Security group name"
  value       = huaweicloud_networking_secgroup.main.name
}

# EIP
output "eip_id" {
  description = "EIP ID"
  value       = var.create_eip ? huaweicloud_vpc_eip.main[0].id : null
}

output "eip_address" {
  description = "EIP public address"
  value       = var.create_eip ? huaweicloud_vpc_eip.main[0].address : null
}

# NAT Gateway
output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = var.create_nat_gateway ? huaweicloud_nat_gateway.main[0].id : null
}
