terraform {
  required_version = ">= 1.3.0"

  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.60.0"
    }
  }
}

provider "huaweicloud" {
  # enterprise_project_id = var.enterprise_project_id
  region                = var.region
  # access_key = var.access_key
  # secret_key = var.secret_key
}
