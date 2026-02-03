# Huawei Cloud Common Terraform Configurations

Reusable Terraform configurations for common Huawei Cloud infrastructure patterns.

## Modules

| Module | Description |
|--------|-------------|
| [common_network](./common_network/) | VPC, Subnets, Security Groups, EIP, NAT Gateway |
| [common_ecs_rds](./common_ecs_rds/) | ECS Instance, RDS Database |
| [common_cce](./common_cce/) | CCE Cluster, Node Pool |

## Usage

1. Navigate to the desired module directory
2. Copy and configure `terraform.tfvars`
3. Run `terraform init && terraform apply`

## Authentication

```bash
export HW_ACCESS_KEY="your-access-key"
export HW_SECRET_KEY="your-secret-key"
export HW_REGION_NAME="tr-west-1"
```

## License

MIT
