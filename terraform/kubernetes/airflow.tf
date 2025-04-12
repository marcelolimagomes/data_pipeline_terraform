resource "helm_release" "airflow" {
  name             = "airflow"
  repository       = "https://airflow.apache.org"
  chart            = "airflow"
  namespace        = "airflow"
  create_namespace = true
  set {
    name  = "executor"
    value = "KubernetesExecutor"
  }
}
