variable "project_name" {
  description = "Data Pipeline Terraform"
  default     = "dev-environment"
}

variable "minio_access_key" {
  description = "Chave de acesso do MinIO"
  default     = "minioadmin"
}

variable "minio_secret_key" {
  description = "Chave secreta do MinIO"
  default     = "miniopassword"
}
