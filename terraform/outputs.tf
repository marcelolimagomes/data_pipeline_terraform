output "minio_namespace_status" {
  value       = kubernetes_namespace.minio.metadata[0].name
  description = "Status do namespace minio"
}

output "airflow_namespace_status" {
  value       = kubernetes_namespace.airflow.metadata[0].name
  description = "Status do namespace airflow"
}

output "kafka_namespace_status" {
  value       = kubernetes_namespace.kafka.metadata[0].name
  description = "Status do namespace kafka"
}

output "postgres_namespace_status" {
  value       = kubernetes_namespace.postgres.metadata[0].name
  description = "Status do namespace postgres"
}

output "pgvector_namespace_status" {
  value       = kubernetes_namespace.pgvector.metadata[0].name
  description = "Status do namespace pgvector"
}

resource "kubernetes_namespace" "minio" {
  metadata {
    name = "minio"
  }
}
resource "kubernetes_namespace" "airflow" {
  metadata {
    name = "airflow"
  }
}
resource "kubernetes_namespace" "kafka" {
  metadata {
    name = "kafka"
  }
}
resource "kubernetes_namespace" "postgres" {
  metadata {
    name = "postgres"
  }
}
resource "kubernetes_namespace" "pgvector" {
  metadata {
    name = "pgvector"
  }
}
