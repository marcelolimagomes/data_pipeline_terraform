resource "helm_release" "kafka" {
  name             = "kafka"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "kafka"
  namespace        = kubernetes_namespace.kafka.metadata[0].name
  depends_on       = [kubernetes_namespace.kafka]
  create_namespace = true
  set {
    name  = "replicaCount"
    value = "1"
  }
}
