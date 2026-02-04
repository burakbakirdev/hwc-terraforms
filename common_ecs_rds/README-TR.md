# Huawei Cloud ECS & RDS Altyapısı

VPC, Subnet, Security Group, ECS instance ve RDS veritabanı içeren komple altyapı oluşturan bağımsız Terraform konfigürasyonu.

## Oluşturulan Kaynaklar

| Kaynak | Açıklama |
|--------|----------|
| VPC | Virtual Private Cloud |
| Subnet'ler | Uygulama ve veritabanı subnet'leri |
| Security Group | SSH, HTTP, HTTPS, MySQL kurallarıyla |
| ECS | Elastic Cloud Server |
| RDS | Relational Database Service (MySQL) |

## İsimlendirme Kuralı

`{kaynak}-{ortam}-{proje_adi}[-{ek}]`

Örnek: `vpc-dev-ecsrds`, `ecs-dev-ecsrds-web`, `rds-dev-ecsrds-mysql`

## Kullanım

### 1. Kimlik Doğrulama

```bash
export HW_ACCESS_KEY="your-access-key"
export HW_SECRET_KEY="your-secret-key"
export HW_REGION_NAME="tr-west-1"
``` 

### 2. Konfigürasyon

`terraform.tfvars` dosyasını düzenleyin:

```hcl
# enterprise_project_id = "your-enterprise-project-id"  # opsiyonel
project_name = "ecsrds"
environment  = "dev"
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
| `security_group_rules` | Güvenlik grubu kuralları | Evet |
| `ecs_name` | ECS instance isim soneki | Evet |
| `ecs_flavor` | ECS flavor | Evet |
| `ecs_image_name` | ECS imaj adı | Evet |
| `ecs_system_disk_type` | Sistem disk tipi (SAS, SSD, GPSSD) | Evet |
| `ecs_system_disk_size` | Sistem disk boyutu (GB) | Evet |
| `ecs_admin_pass` | ECS yönetici şifresi | Evet |
| `rds_name` | RDS instance isim soneki | Evet |
| `rds_flavor` | RDS flavor | Evet |
| `rds_engine` | Veritabanı motoru | Evet |
| `rds_engine_version` | RDS motor versiyonu | Evet |
| `rds_volume_type` | RDS volume tipi | Evet |
| `rds_volume_size` | RDS volume boyutu (GB) | Evet |
| `rds_password` | RDS yönetici şifresi | Evet |
| `rds_backup_start_time` | RDS yedekleme başlangıç saati | Evet |
| `rds_backup_keep_days` | RDS yedek saklama süresi (gün) | Evet |
| `tags` | Kaynak etiketleri | Evet |

## Output'lar

| Output | Açıklama |
|--------|----------|
| `vpc_id` | VPC ID |
| `subnet_ids` | Subnet isimleri ve ID'leri haritası |
| `security_group_id` | Güvenlik grubu ID |
| `ecs_id` | ECS instance ID |
| `ecs_name` | ECS instance adı |
| `ecs_private_ip` | ECS özel IP |
| `rds_id` | RDS instance ID |
| `rds_name` | RDS instance adı |
| `rds_private_ips` | RDS özel IP'leri |

## Güvenlik Notu

- `terraform.tfvars` dosyasını gerçek credential'larla commit etmeyin
- Kimlik doğrulama için environment variable kullanın
- Production'da SSH erişimini belirli IP'lerle sınırlayın
