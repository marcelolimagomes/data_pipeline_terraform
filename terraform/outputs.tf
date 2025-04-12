output "minio_endpoint" {
  value = "http://localhost:9000"
}

output "airflow_webserver" {
  value = "http://localhost:8080"
}

output "metabase_endpoint" {
  value = "http://localhost:3000"
}

output "postgres_endpoint" {
  value = "postgresql://airflow:airflow@localhost:5433/airflow"
}

output "pgvector_endpoint" {
  value = "postgresql://pgvector:pgvector@localhost:5432/vector_db"
}

output "kafka_ui_endpoint" {
  value = "http://localhost:8081"
}

output "jupyter_endpoint" {
  value = "http://localhost:8888"
}
