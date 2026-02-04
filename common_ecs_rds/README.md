# Huawei Cloud ECS & RDS Infrastructure

Standalone Terraform configuration that creates a complete infrastructure with VPC, Subnets, Security Groups, ECS instance and RDS database.

## Resources Created

| Resource | Description |
|----------|-------------|
| VPC | Virtual Private Cloud |
| Subnets | Application and database subnets |
| Security Group | With SSH, HTTP, HTTPS, MySQL rules |
| ECS | Elastic Cloud Server |
| RDS | Relational Database Service (MySQL) |

## Naming Convention

`{resource}-{environment}-{project_name}[-{suffix}]`

Example: `vpc-dev-ecsrds`, `ecs-dev-ecsrds-web`, `rds-dev-ecsrds-mysql`

## Usage

### 1. Authentication

```bash
export HW_ACCESS_KEY="your-access-key"
export HW_SECRET_KEY="your-secret-key"
export HW_REGION_NAME="tr-west-1"
```

### 2. Configuration

Edit `terraform.tfvars` with your values:

```hcl
# enterprise_project_id = "your-enterprise-project-id"  # optional
project_name = "ecsrds"
environment  = "dev"
```

### 3. Deploy

```bash
terraform init
terraform plan
terraform apply
```

### 4. Destroy

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
| `subnets` | List of subnets | Yes |
| `security_group_rules` | Security group rules | Yes |
| `ecs_name` | ECS instance name suffix | Yes |
| `ecs_flavor` | ECS flavor | Yes |
| `ecs_image_name` | ECS image name | Yes |
| `ecs_system_disk_type` | System disk type (SAS, SSD, GPSSD) | Yes |
| `ecs_system_disk_size` | System disk size in GB | Yes |
| `ecs_admin_pass` | Admin password for ECS | Yes |
| `rds_name` | RDS instance name suffix | Yes |
| `rds_flavor` | RDS flavor | Yes |
| `rds_engine` | Database engine | Yes |
| `rds_engine_version` | RDS engine version | Yes |
| `rds_volume_type` | RDS volume type | Yes |
| `rds_volume_size` | RDS volume size in GB | Yes |
| `rds_password` | RDS admin password | Yes |
| `rds_backup_start_time` | RDS backup start time | Yes |
| `rds_backup_keep_days` | RDS backup retention days | Yes |
| `tags` | Resource tags | Yes |

## Outputs

| Output | Description |
|--------|-------------|
| `vpc_id` | VPC ID |
| `subnet_ids` | Map of subnet names to IDs |
| `security_group_id` | Security group ID |
| `ecs_id` | ECS instance ID |
| `ecs_name` | ECS instance name |
| `ecs_private_ip` | ECS private IP |
| `rds_id` | RDS instance ID |
| `rds_name` | RDS instance name |
| `rds_private_ips` | RDS private IPs |

## Security Note

- Never commit `terraform.tfvars` with real credentials
- Use environment variables for authentication
- Restrict SSH access to specific IPs in production
