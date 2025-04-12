resource "helm_release" "postgresql" {
  name             = "postgresql"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "postgresql"
  namespace        = "postgres"
  create_namespace = true
  set {
    name  = "global.postgresql.auth.database"
    value = "myapp"
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
