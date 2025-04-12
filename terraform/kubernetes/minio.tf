resource "helm_release" "minio" {
  name       = "minio"
  repository = "https://charts.min.io/"
  chart      = "minio"
  namespace  = kubernetes_namespace.minio.metadata[0].name
  depends_on = [kubernetes_namespace.minio]
  set {
    name  = "mode"
    value = "standalone"
  }
  set {
    name  = "rootUser"
    value = "admin"
  }
  set {
    name  = "rootPassword"
    value = "password"
  }
  set {
    name  = "persistence.enabled"
    value = "true"
  }
}
