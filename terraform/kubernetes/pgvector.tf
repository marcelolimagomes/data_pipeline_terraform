resource "helm_release" "pgvector" {
  name             = "pgvector"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "postgresql"
  namespace        = kubernetes_namespace.pgvector.metadata[0].name
  depends_on       = [kubernetes_namespace.pgvector]
  create_namespace = true
  set {
    name  = "image.repository"
    value = "ankane/pgvector"
  }
  set {
    name  = "image.tag"
    value = "latest"
  }
  set {
    name  = "global.postgresql.auth.database"
    value = "pgvector"
  }
  set {
    name  = "global.postgresql.auth.username"
    value = "postgres"
  }
  set {
    name  = "global.postgresql.auth.password"
    value = "postgres"
  }
}
