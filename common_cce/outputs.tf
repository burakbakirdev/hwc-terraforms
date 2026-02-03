# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = huaweicloud_vpc.main.id
}

# Node Subnet
output "node_subnet_id" {
  description = "Node subnet ID"
  value       = huaweicloud_vpc_subnet.node.id
}

# Pod Subnets
output "pod_subnet_ids" {
  description = "Pod subnet IDs"
  value       = { for k, v in huaweicloud_vpc_subnet.pod : k => v.id }
}

output "pod_subnet_ipv4_ids" {
  description = "Pod subnet IPv4 IDs (for ENI)"
  value       = { for k, v in huaweicloud_vpc_subnet.pod : k => v.ipv4_subnet_id }
}

# CCE Cluster
output "cluster_id" {
  description = "CCE cluster ID"
  value       = huaweicloud_cce_cluster.main.id
}

output "cluster_name" {
  description = "CCE cluster name"
  value       = huaweicloud_cce_cluster.main.name
}

output "cluster_status" {
  description = "CCE cluster status"
  value       = huaweicloud_cce_cluster.main.status
}

output "kube_config_raw" {
  description = "Kubeconfig content"
  value       = huaweicloud_cce_cluster.main.kube_config_raw
  sensitive   = true
}

output "cluster_internal_endpoint" {
  description = "Cluster internal API endpoint"
  value       = huaweicloud_cce_cluster.main.certificate_clusters[0].server
}

# Node Pool
output "nodepool_id" {
  description = "Node pool ID"
  value       = huaweicloud_cce_node_pool.main.id
}

output "nodepool_name" {
  description = "Node pool name"
  value       = huaweicloud_cce_node_pool.main.name
}

output "nodepool_status" {
  description = "Node pool status"
  value       = huaweicloud_cce_node_pool.main.status
}
