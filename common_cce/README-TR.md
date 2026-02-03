# Huawei Cloud CCE Turbo Altyapısı

ENI network ve ayrılmış pod subnet'leriyle CCE Turbo cluster için bağımsız Terraform konfigürasyonu.

## Oluşturulan Kaynaklar

| Kaynak | Açıklama |
|--------|----------|
| VPC | Virtual Private Cloud |
| Node Subnet | CCE worker node'ları için subnet |
| Pod Subnet'leri | Pod networking için 3 subnet (ENI) |
| CCE Cluster | ENI network ile Kubernetes Turbo cluster |
| Node Pool | Autoscaling destekli worker node'lar |

## Network Mimarisi

```
VPC (10.2.0.0/16)
├── Node Subnet (10.2.0.0/24) - CCE worker node'ları
├── Pod Subnet 1 (10.2.1.0/24) - Pod IP'leri
├── Pod Subnet 2 (10.2.2.0/24) - Pod IP'leri
└── Pod Subnet 3 (10.2.3.0/24) - Pod IP'leri
```

## İsimlendirme Kuralı

`{kaynak}-{ortam}-{proje_adi}[-{ek}]`

Örnek: `vpc-dev-cce`, `cce-dev-cce`, `nodepool-dev-cce-default`

## Kullanım

### 1. Kimlik Doğrulama

```bash
export HW_ACCESS_KEY="your-access-key"
export HW_SECRET_KEY="your-secret-key"
export HW_REGION_NAME="tr-west-1"
```

### 2. Konfigürasyon

`terraform.tfvars` dosyasını düzenleyin.

### 3. Deploy

```bash
terraform init
terraform plan
terraform apply
```

### 4. Kubeconfig Alma

```bash
terraform output -raw kube_config_raw > ~/.kube/config
kubectl get nodes
```

### 5. Temizlik

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
| `node_subnet` | Node subnet konfigürasyonu | Evet |
| `pod_subnets` | ENI için pod subnet listesi | Evet |
| `cce_cluster_flavor` | Cluster flavor (Turbo için cce.s2.small) | Evet |
| `cce_cluster_type` | CCE cluster tipi | Hayır |
| `cce_service_network_cidr` | Servis ağı CIDR | Evet |
| `cce_cluster_version` | Kubernetes versiyonu | Evet |
| `nodepool_name` | Node pool isim soneki | Evet |
| `nodepool_flavor` | Node flavor | Evet |
| `nodepool_os` | Node işletim sistemi | Evet |
| `nodepool_initial_node_count` | Başlangıç node sayısı | Evet |
| `nodepool_min_node_count` | Minimum node sayısı | Evet |
| `nodepool_max_node_count` | Maksimum node sayısı | Evet |
| `nodepool_root_volume_type` | Root disk tipi | Evet |
| `nodepool_root_volume_size` | Root disk boyutu (GB) | Evet |
| `nodepool_data_volume_type` | Veri diski tipi | Evet |
| `nodepool_data_volume_size` | Veri diski boyutu (GB) | Evet |
| `nodepool_key_pair` | SSH anahtar çifti adı | Hayır |
| `nodepool_password` | Node şifresi | Hayır |
| `tags` | Kaynak etiketleri | Evet |

## Output'lar

| Output | Açıklama |
|--------|----------|
| `vpc_id` | VPC ID |
| `node_subnet_id` | Node subnet ID |
| `pod_subnet_ids` | Pod subnet ID'leri |
| `cluster_id` | CCE cluster ID |
| `kube_config_raw` | Kubeconfig içeriği (sensitive) |
| `nodepool_id` | Node pool ID |

## Güvenlik Notu

- Node pool'da AZ belirtilmedi, otomatik dağıtım yapılıyor
- Kimlik doğrulama için environment variable kullanın
- Pod subnet'leri izolasyon için node subnet'inden ayrı
