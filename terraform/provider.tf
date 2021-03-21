terraform {
  required_providers {
    pagerduty = {
      source = "PagerDuty/pagerduty"
      version = ">= 1.9.5"
    }

    cloudflare = {
      source = "cloudflare/cloudflare"
      version = ">= 2.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
  }
}

terraform {
  backend "gcs" {
    bucket = "tf-state-pez"
    prefix = "terraform/state"
  }
}

provider "cloudflare" {
  email = "pez@pez.sh"
  api_key = file("./.cloudflare_api_key.txt")
}

provider "google" {
  project = "rwejlgaard"
}

data "google_client_config" "client-config" {}

provider "kubernetes" {
  host = google_container_cluster.k8s.endpoint
  token = data.google_client_config.client-config.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.k8s.master_auth[0].cluster_ca_certificate)
}

provider "google-beta" {
  project = "rwejlgaard"
}

provider "pagerduty" {
  token = file("./.pagerduty_api_key.txt")
}

