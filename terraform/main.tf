terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  host                   = "https://${data.external.minikube_ip.result.ip}:8443"
  client_certificate     = file("~/.minikube/profiles/minikube/client.crt")
  client_key             = file("~/.minikube/profiles/minikube/client.key")
  cluster_ca_certificate = file("~/.minikube/ca.crt")
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.external.minikube_ip.result.ip}:8443"
    client_certificate     = file("~/.minikube/profiles/minikube/client.crt")
    client_key             = file("~/.minikube/profiles/minikube/client.key")
    cluster_ca_certificate = file("~/.minikube/ca.crt")
  }
}

data "external" "minikube_ip" {
  program = ["bash", "-c", "echo '{\"ip\": \"'$(minikube ip)'\"}'"]
}
