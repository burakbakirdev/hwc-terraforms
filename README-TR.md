# Huawei Cloud Ortak Terraform Konfigürasyonları

Huawei Cloud altyapısı için tekrar kullanılabilir Terraform konfigürasyonları.

## Modüller

| Modül | Açıklama |
|-------|----------|
| [common_network](./common_network/) | VPC, Subnet, Security Group, EIP, NAT Gateway |

## Kullanım

1. İstenen modül klasörüne gidin
2. `terraform.tfvars` dosyasını kopyalayın ve yapılandırın
3. `terraform init && terraform apply` komutunu çalıştırın

## Kimlik Doğrulama

```bash
export HW_ACCESS_KEY="your-access-key"
export HW_SECRET_KEY="your-secret-key"
export HW_REGION_NAME="tr-west-1"
```

## Lisans

MIT
