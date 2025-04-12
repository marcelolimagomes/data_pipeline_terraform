resource "helm_release" "airflow" {
  name             = "airflow"
  repository       = "https://airflow.apache.org"
  chart            = "airflow"
  namespace        = kubernetes_namespace.airflow.metadata[0].name
  depends_on       = [kubernetes_namespace.airflow]
  create_namespace = true
  set {
    name  = "executor"
    value = "KubernetesExecutor"
  }
}
