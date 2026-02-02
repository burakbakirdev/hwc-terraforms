# Huawei Cloud Network Infrastructure

This Terraform configuration creates a common network infrastructure on Huawei Cloud.

## Resources Created

- **VPC** - Virtual Private Cloud
- **Subnets** - Public and private subnets
- **Security Group** - Security group with configurable rules
- **EIP** - Elastic IP (optional)
- **NAT Gateway** - NAT Gateway with SNAT rule (optional)

## Naming Convention

Resources follow the pattern: `{resource}-{environment}-{project_name}`

Example with `project_name = "common"` and `environment = "dev"`:
- VPC: `vpc-dev-common`
- Subnet: `subnet-dev-common-public-1`
- Security Group: `sg-dev-common`
- EIP: `eip-dev-common`
- NAT Gateway: `nat-dev-common`

## Usage

### 1. Authentication

Set environment variables (recommended):

```bash
export HW_ACCESS_KEY="your-access-key"
export HW_SECRET_KEY="your-secret-key"
export HW_REGION_NAME="tr-west-1"
```

### 2. Configuration

Edit `terraform.tfvars` with your values:

```hcl
# enterprise_project_id = "your-enterprise-project-id"  # optional
project_name          = "common"
environment           = "dev"
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
| `enterprise_project_id` | Enterprise project ID | No |
| `project_name` | Project name for resource naming | Yes |
| `environment` | Environment (dev, staging, prod) | Yes |
| `vpc_cidr` | VPC CIDR block | Yes |
| `subnets` | List of subnets | Yes |
| `create_eip` | Create Elastic IP | Yes |
| `create_nat_gateway` | Create NAT Gateway | Yes |

## Outputs

| Output | Description |
|--------|-------------|
| `vpc_id` | VPC ID |
| `subnet_ids` | Map of subnet names to IDs |
| `security_group_id` | Security group ID |
| `eip_address` | EIP public address |
| `nat_gateway_id` | NAT Gateway ID |

## Security Note

- Never commit `terraform.tfvars` with real credentials
- Use environment variables for authentication
- Add `terraform.tfvars` to `.gitignore`
