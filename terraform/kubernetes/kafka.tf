resource "helm_release" "kafka" {
  name             = "kafka"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "kafka"
  namespace        = "kafka"
  create_namespace = true
}
