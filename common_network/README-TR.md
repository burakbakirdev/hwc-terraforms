# Huawei Cloud Network Altyapısı

Bu Terraform konfigürasyonu Huawei Cloud üzerinde ortak network altyapısı oluşturur.

## Oluşturulan Kaynaklar

- **VPC** - Virtual Private Cloud
- **Subnet'ler** - Public ve private subnet'ler
- **Security Group** - Yapılandırılabilir kurallarla güvenlik grubu
- **EIP** - Elastic IP (opsiyonel)
- **NAT Gateway** - SNAT kuralı ile NAT Gateway (opsiyonel)

## İsimlendirme Kuralı

Kaynaklar şu formatta isimlenir: `{kaynak}-{ortam}-{proje_adi}`

`project_name = "common"` ve `environment = "dev"` için örnek:
- VPC: `vpc-dev-common`
- Subnet: `subnet-dev-common-public-1`
- Security Group: `sg-dev-common`
- EIP: `eip-dev-common`
- NAT Gateway: `nat-dev-common`

## Kullanım

### 1. Kimlik Doğrulama

Environment variable'ları ayarlayın (önerilen):

```bash
export HW_ACCESS_KEY="your-access-key"
export HW_SECRET_KEY="your-secret-key"
export HW_REGION_NAME="tr-west-1"
```

### 2. Konfigürasyon

`terraform.tfvars` dosyasını kendi değerlerinizle düzenleyin:

```hcl
# enterprise_project_id = "your-enterprise-project-id"  # opsiyonel
project_name          = "common"
environment           = "dev"
```

### 3. Deploy

```bash
terraform init
terraform plan
terraform apply
```

### 4. Temizlik

```bash
terraform destroy
```

## Değişkenler

| Değişken | Açıklama | Zorunlu |
|----------|----------|---------|
| `region` | Huawei Cloud bölgesi | Evet |
| `access_key` | Huawei Cloud erişim anahtarı | Evet |
| `secret_key` | Huawei Cloud gizli anahtarı | Evet |
| `enterprise_project_id` | Kurumsal proje kimliği | Hayır |
| `project_name` | Kaynak isimlendirmesi için proje adı | Evet |
| `environment` | Ortam (dev, staging, prod) | Evet |
| `vpc_cidr` | VPC CIDR bloğu | Evet |
| `subnets` | Subnet listesi | Evet |
| `create_eip` | EIP oluşturulsun mu | Evet |
| `eip_bandwidth_size` | EIP bant genişliği (Mbit/s) | Evet |
| `eip_bandwidth_share_type` | Bant genişliği tipi (PER veya WHOLE) | Evet |
| `remote_ip` | SSH erişimi için izin verilen IP | Evet |
| `security_group_rules` | Güvenlik grubu kuralları | Evet |
| `create_nat_gateway` | NAT Gateway oluşturulsun mu | Evet |
| `nat_gateway_spec` | NAT özellikleri (1-4) | Evet |
| `tags` | Kaynak etiketleri | Evet |

## Output'lar

| Output | Açıklama |
|--------|----------|
| `vpc_id` | VPC ID |
| `subnet_ids` | Subnet isimlerinden ID'lere map |
| `security_group_id` | Security group ID |
| `eip_address` | EIP public adresi |
| `nat_gateway_id` | NAT Gateway ID |

## Güvenlik Notu

- `terraform.tfvars` dosyasını gerçek credential'larla commit etmeyin
- Kimlik doğrulama için environment variable kullanın
- `terraform.tfvars` dosyasını `.gitignore`'a ekleyin
