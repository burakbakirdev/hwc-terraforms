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

# Image Data
data "huaweicloud_images_image" "ecs" {
  name        = var.ecs_image_name
  visibility  = "public"
  most_recent = true
}

# ECS Instance
resource "huaweicloud_compute_instance" "main" {
  name               = "ecs-${local.name_prefix}-${var.ecs_name}"
  flavor_id          = var.ecs_flavor
  image_id           = data.huaweicloud_images_image.ecs.id
  security_group_ids = [huaweicloud_networking_secgroup.main.id]
  availability_zone  = var.subnets[0].availability_zone
  admin_pass         = var.ecs_admin_pass

  system_disk_type = var.ecs_system_disk_type
  system_disk_size = var.ecs_system_disk_size

  network {
    uuid = values(huaweicloud_vpc_subnet.subnets)[0].id
  }

  tags = local.common_tags
}

# RDS Instance
resource "huaweicloud_rds_instance" "main" {
  name              = "rds-${local.name_prefix}-${var.rds_name}"
  flavor            = var.rds_flavor
  vpc_id            = huaweicloud_vpc.main.id
  subnet_id         = values(huaweicloud_vpc_subnet.subnets)[0].id
  security_group_id = huaweicloud_networking_secgroup.main.id
  availability_zone = [var.subnets[0].availability_zone]

  db {
    type     = var.rds_engine
    version  = var.rds_engine_version
    password = var.rds_password
  }

  volume {
    type = var.rds_volume_type
    size = var.rds_volume_size
  }

  backup_strategy {
    start_time = var.rds_backup_start_time
    keep_days  = var.rds_backup_keep_days
  }

  tags = local.common_tags
}
