locals {
  name_prefix = "${var.environment}-${var.project_name}"
  common_tags = merge(var.tags, {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  })
}

# VPC
resource "huaweicloud_vpc" "main" {
  name                  = "vpc-${local.name_prefix}"
  cidr                  = var.vpc_cidr
  enterprise_project_id = var.enterprise_project_id
  tags                  = local.common_tags
}

# Subnets
resource "huaweicloud_vpc_subnet" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name              = "subnet-${local.name_prefix}-${each.value.name}"
  cidr              = each.value.cidr
  gateway_ip        = each.value.gateway_ip
  vpc_id            = huaweicloud_vpc.main.id
  availability_zone = each.value.availability_zone
  primary_dns       = "100.125.1.250"
  secondary_dns     = "100.125.129.250"
  tags              = local.common_tags
}

# Security Group
resource "huaweicloud_networking_secgroup" "main" {
  name                  = "sg-${local.name_prefix}"
  description           = "Security group for ${var.project_name} ${var.environment}"
  delete_default_rules  = true
  enterprise_project_id = var.enterprise_project_id
}

resource "huaweicloud_networking_secgroup_rule" "rules" {
  for_each = { for rule in var.security_group_rules : "${rule.direction}-${rule.protocol}-${rule.port_range_min}" => rule }

  security_group_id = huaweicloud_networking_secgroup.main.id
  description       = each.value.description
  direction         = each.value.direction
  ethertype         = each.value.ethertype
  protocol          = each.value.protocol
  port_range_min    = each.value.port_range_min
  port_range_max    = each.value.port_range_max
  remote_ip_prefix  = each.value.remote_ip_prefix
}

resource "huaweicloud_networking_secgroup_rule" "egress" {
  security_group_id = huaweicloud_networking_secgroup.main.id
  description       = "Allow all outbound"
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
}

# EIP
resource "huaweicloud_vpc_eip" "main" {
  count = var.create_eip ? 1 : 0

  publicip {
    type = "5_bgp"
  }

  bandwidth {
    name        = "eip-${local.name_prefix}"
    size        = var.eip_bandwidth_size
    share_type  = var.eip_bandwidth_share_type
    charge_mode = "traffic"
  }

  enterprise_project_id = var.enterprise_project_id
  tags                  = local.common_tags
}

# NAT Gateway
resource "huaweicloud_nat_gateway" "main" {
  count = var.create_nat_gateway ? 1 : 0

  name                  = "nat-${local.name_prefix}"
  description           = "NAT Gateway for ${var.project_name} ${var.environment}"
  spec                  = var.nat_gateway_spec
  vpc_id                = huaweicloud_vpc.main.id
  subnet_id             = values(huaweicloud_vpc_subnet.subnets)[0].id
  enterprise_project_id = var.enterprise_project_id
  tags                  = local.common_tags
}

resource "huaweicloud_nat_snat_rule" "main" {
  count = var.create_nat_gateway && var.create_eip ? 1 : 0

  nat_gateway_id = huaweicloud_nat_gateway.main[0].id
  floating_ip_id = huaweicloud_vpc_eip.main[0].id
  subnet_id      = values(huaweicloud_vpc_subnet.subnets)[0].id
}
