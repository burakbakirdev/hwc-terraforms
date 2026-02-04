# Authentication via environment variables (recommended):
# $ export HW_ACCESS_KEY="anaccesskey"
# $ export HW_SECRET_KEY="asecretkey"
# $ export HW_REGION_NAME="tr-west-1"

# Provider
region     = "tr-west-1"
access_key = "YOUR_ACCESS_KEY"
secret_key = "YOUR_SECRET_KEY"

# Enterprise Project (optional)
enterprise_project_id = "YOUR_ENTERPRISE_PROJECT_ID"

# Project
project_name = "cce"
environment  = "dev"

# VPC
vpc_cidr = "10.2.0.0/16"

# Node Subnet (for CCE nodes)
node_subnet = {
  name       = "node"
  cidr       = "10.2.0.0/24"
  gateway_ip = "10.2.0.1"
}

# Pod Subnets (for ENI network - pods will use these)
pod_subnets = [
  {
    name       = "pod-1"
    cidr       = "10.2.1.0/24"
    gateway_ip = "10.2.1.1"
  },
  {
    name       = "pod-2"
    cidr       = "10.2.2.0/24"
    gateway_ip = "10.2.2.1"
  },
  {
    name       = "pod-3"
    cidr       = "10.2.3.0/24"
    gateway_ip = "10.2.3.1"
  }
]

# CCE Cluster (Turbo with ENI)
cce_cluster_flavor       = "cce.s2.small"
cce_cluster_type         = "VirtualMachine"
cce_service_network_cidr = "10.248.0.0/16"
cce_cluster_version      = "v1.32"

# CCE Node Pool (no AZ - automatic distribution)
nodepool_name               = "default"
nodepool_flavor             = "c7n.2xlarge.2"
nodepool_os                 = "Ubuntu 22.04"
nodepool_initial_node_count = 2
nodepool_min_node_count     = 2
nodepool_max_node_count     = 5
nodepool_root_volume_type   = "GPSSD"
nodepool_root_volume_size   = 50
nodepool_data_volume_type   = "GPSSD"
nodepool_data_volume_size   = 100
nodepool_key_pair           = ""
nodepool_password           = "<YOUR_NODE_PASSWORD>"

# Tags
tags = {
  Team       = "your-team"
  CostCenter = "your-cost-center"
  Owner      = "your-name"
  time       = "2026-02-05"
}
