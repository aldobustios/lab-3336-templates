terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
}

provider "kubernetes" {
  host                   = var.k8s_host
  token                  = var.k8s_token
  cluster_ca_certificate = base64decode(var.k8s_ca_cert)
}

resource "kubernetes_manifest" "gateway" {
  manifest = {
    apiVersion = "datapower.ibm.com/v1beta3"
    kind       = "DataPowerService"
    metadata = {
      name      = "${{ values.namespace }}-${{ values.gateway_name }}"
      namespace = "${{ values.namespace }}"
      labels = {
        app         = "${{ values.gateway_name }}"
        environment = "${{ values.environment }}"
        owner       = "${{ values.namespace }}"
      }
    }
    spec = {
      replicas = ${{ values.replicas }}
      version  = "10.5.0.10"
      license = {
        accept     = true
        use        = "nonproduction"
        license    = "L-RJON-CCAT5F"
      }
      users = [{
        name              = "admin"
        accessLevel       = "privileged"
        passwordSecret    = "datapower-admin-credentials"
      }]
      gateway = {
        enabled = true
      }
    }
  }
}

output "gateway_name" {
  value = "${{ values.namespace }}-${{ values.gateway_name }}"
}

output "gateway_namespace" {
  value = "${{ values.namespace }}"
}
