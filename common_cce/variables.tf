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

# Node Subnet (for CCE nodes)
variable "node_subnet" {
  description = "Node subnet configuration"
  type = object({
    name       = string
    cidr       = string
    gateway_ip = string
  })
}

# Pod Subnets (for ENI network - pods will use these)
variable "pod_subnets" {
  description = "List of pod subnets for ENI network"
  type = list(object({
    name       = string
    cidr       = string
    gateway_ip = string
  }))
}

# CCE Cluster
variable "cce_cluster_flavor" {
  description = "CCE cluster flavor (cce.s1.small, cce.s2.small for Turbo)"
  type        = string
}

variable "cce_cluster_type" {
  description = "CCE cluster type (VirtualMachine or ARM64)"
  type        = string
  default     = "VirtualMachine"
}

variable "cce_service_network_cidr" {
  description = "Service network CIDR"
  type        = string
}

variable "cce_cluster_version" {
  description = "Kubernetes version"
  type        = string
}

# CCE Node Pool
variable "nodepool_name" {
  description = "Node pool name suffix"
  type        = string
}

variable "nodepool_flavor" {
  description = "Node flavor (e.g., s6.large.2)"
  type        = string
}

variable "nodepool_os" {
  description = "Node OS (EulerOS 2.9, Ubuntu 22.04, etc.)"
  type        = string
}

variable "nodepool_initial_node_count" {
  description = "Initial number of nodes"
  type        = number
}

variable "nodepool_min_node_count" {
  description = "Minimum number of nodes (autoscaling)"
  type        = number
}

variable "nodepool_max_node_count" {
  description = "Maximum number of nodes (autoscaling)"
  type        = number
}

variable "nodepool_root_volume_type" {
  description = "Root volume type (SAS, SSD, GPSSD)"
  type        = string
}

variable "nodepool_root_volume_size" {
  description = "Root volume size in GB"
  type        = number
}

variable "nodepool_data_volume_type" {
  description = "Data volume type (SAS, SSD, GPSSD)"
  type        = string
}

variable "nodepool_data_volume_size" {
  description = "Data volume size in GB"
  type        = number
}

variable "nodepool_key_pair" {
  description = "SSH key pair name (optional, use password if empty)"
  type        = string
  default     = ""
}

variable "nodepool_password" {
  description = "Node password (used if key_pair is empty)"
  type        = string
  sensitive   = true
  default     = ""
}

# Tags
variable "tags" {
  description = "Resource tags"
  type        = map(string)
}
