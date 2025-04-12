terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  access_key = "mock_access_key"
  secret_key = "mock_secret_key"
  region     = "us-east-1"
  endpoints {
    s3  = "http://localhost:4566"
    eks = "http://localhost:4566"
  }
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
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
