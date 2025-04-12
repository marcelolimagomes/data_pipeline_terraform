resource "docker_network" "app_network" {
  name   = "${var.project_name}-network"
  driver = "bridge"
}

resource "docker_volume" "minio_data" {
  name = "${var.project_name}-minio-data"
}

resource "docker_volume" "kafka_data" {
  name = "${var.project_name}-kafka-data"
}

resource "docker_volume" "zookeeper_data" {
  name = "${var.project_name}-zookeeper-data"
}

resource "docker_volume" "postgres_data" {
  name = "${var.project_name}-postgres-data"
}

resource "docker_volume" "pgvector_data" {
  name = "${var.project_name}-pgvector-data"
}

resource "docker_volume" "metabase_data" {
  name = "${var.project_name}-metabase-data"
}

resource "docker_volume" "kafka_ui_data" {
  name = "${var.project_name}-kafka-ui-data"
}

resource "docker_volume" "jupyter_data" {
  name = "${var.project_name}-jupyter-data"
}
