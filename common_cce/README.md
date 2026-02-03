# Huawei Cloud CCE Turbo Infrastructure

Standalone Terraform configuration for CCE Turbo cluster with ENI network and dedicated pod subnets.

## Resources Created

| Resource | Description |
|----------|-------------|
| VPC | Virtual Private Cloud |
| Node Subnet | Subnet for CCE worker nodes |
| Pod Subnets | 3 subnets for pod networking (ENI) |
| CCE Cluster | Kubernetes Turbo cluster with ENI network |
| Node Pool | Worker nodes with autoscaling |

## Network Architecture

```
VPC (10.2.0.0/16)
├── Node Subnet (10.2.0.0/24) - CCE worker nodes
├── Pod Subnet 1 (10.2.1.0/24) - Pod IPs
├── Pod Subnet 2 (10.2.2.0/24) - Pod IPs
└── Pod Subnet 3 (10.2.3.0/24) - Pod IPs
```

## Naming Convention

`{resource}-{environment}-{project_name}[-{suffix}]`

Example: `vpc-dev-cce`, `cce-dev-cce`, `nodepool-dev-cce-default`

## Usage

### 1. Authentication

```bash
export HW_ACCESS_KEY="your-access-key"
export HW_SECRET_KEY="your-secret-key"
export HW_REGION_NAME="tr-west-1"
```

### 2. Configuration

Edit `terraform.tfvars` with your values.

### 3. Deploy

```bash
terraform init
terraform plan
terraform apply
```

### 4. Get Kubeconfig

```bash
terraform output -raw kube_config_raw > ~/.kube/config
kubectl get nodes
```

### 5. Destroy

```bash
terraform destroy
```

## Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `region` | Huawei Cloud region | Yes |
| `access_key` | Huawei Cloud access key | Yes |
| `secret_key` | Huawei Cloud secret key | Yes |
| `enterprise_project_id` | Enterprise project ID | No |
| `project_name` | Project name for resource naming | Yes |
| `environment` | Environment (dev, staging, prod) | Yes |
| `vpc_cidr` | VPC CIDR block | Yes |
| `node_subnet` | Node subnet configuration | Yes |
| `pod_subnets` | List of pod subnets for ENI | Yes |
| `cce_cluster_flavor` | Cluster flavor (cce.s2.small for Turbo) | Yes |
| `cce_cluster_type` | CCE cluster type | No |
| `cce_service_network_cidr` | Service network CIDR | Yes |
| `cce_cluster_version` | Kubernetes version | Yes |
| `nodepool_name` | Node pool name suffix | Yes |
| `nodepool_flavor` | Node flavor | Yes |
| `nodepool_os` | Node OS | Yes |
| `nodepool_initial_node_count` | Initial number of nodes | Yes |
| `nodepool_min_node_count` | Minimum number of nodes | Yes |
| `nodepool_max_node_count` | Maximum number of nodes | Yes |
| `nodepool_root_volume_type` | Root volume type | Yes |
| `nodepool_root_volume_size` | Root volume size in GB | Yes |
| `nodepool_data_volume_type` | Data volume type | Yes |
| `nodepool_data_volume_size` | Data volume size in GB | Yes |
| `nodepool_key_pair` | SSH key pair name | No |
| `nodepool_password` | Node password | No |
| `tags` | Resource tags | Yes |

## Outputs

| Output | Description |
|--------|-------------|
| `vpc_id` | VPC ID |
| `node_subnet_id` | Node subnet ID |
| `pod_subnet_ids` | Pod subnet IDs |
| `cluster_id` | CCE cluster ID |
| `kube_config_raw` | Kubeconfig content (sensitive) |
| `nodepool_id` | Node pool ID |

## Security Note

- Node pool has no AZ specified for automatic distribution
- Use environment variables for authentication
- Pod subnets are separate from node subnet for better isolation
