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

# Node Subnet
resource "huaweicloud_vpc_subnet" "node" {
  name       = "subnet-${local.name_prefix}-${var.node_subnet.name}"
  cidr       = var.node_subnet.cidr
  gateway_ip = var.node_subnet.gateway_ip
  vpc_id     = huaweicloud_vpc.main.id

  tags = local.common_tags
}

# Pod Subnets (for ENI network)
resource "huaweicloud_vpc_subnet" "pod" {
  for_each = { for subnet in var.pod_subnets : subnet.name => subnet }

  name       = "subnet-${local.name_prefix}-${each.value.name}"
  cidr       = each.value.cidr
  gateway_ip = each.value.gateway_ip
  vpc_id     = huaweicloud_vpc.main.id

  tags = local.common_tags
}

# CCE Turbo Cluster with ENI network
resource "huaweicloud_cce_cluster" "main" {
  name                   = "cce-${local.name_prefix}"
  flavor_id              = var.cce_cluster_flavor
  cluster_type           = var.cce_cluster_type
  vpc_id                 = huaweicloud_vpc.main.id
  subnet_id              = huaweicloud_vpc_subnet.node.id
  container_network_type = "eni"
  service_network_cidr   = var.cce_service_network_cidr
  cluster_version        = var.cce_cluster_version

  # ENI network requires eni_subnet_id (ipv4_subnet_id of pod subnets)
  eni_subnet_id = join(",", [for s in huaweicloud_vpc_subnet.pod : s.ipv4_subnet_id])

  tags = local.common_tags
}

# CCE Node Pool (no AZ - automatic distribution)
resource "huaweicloud_cce_node_pool" "main" {
  cluster_id         = huaweicloud_cce_cluster.main.id
  name               = "nodepool-${local.name_prefix}-${var.nodepool_name}"
  os                 = var.nodepool_os
  flavor_id          = var.nodepool_flavor
  key_pair           = var.nodepool_key_pair != "" ? var.nodepool_key_pair : null
  password           = var.nodepool_key_pair == "" ? var.nodepool_password : null
  initial_node_count = var.nodepool_initial_node_count
  min_node_count     = var.nodepool_min_node_count
  max_node_count     = var.nodepool_max_node_count
  scall_enable       = var.nodepool_min_node_count != var.nodepool_max_node_count

  root_volume {
    volumetype = var.nodepool_root_volume_type
    size       = var.nodepool_root_volume_size
  }

  data_volumes {
    volumetype = var.nodepool_data_volume_type
    size       = var.nodepool_data_volume_size
  }

  tags = local.common_tags
}
