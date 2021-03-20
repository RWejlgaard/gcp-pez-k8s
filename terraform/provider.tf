terraform {
  required_providers {
    pagerduty = {
      source = "PagerDuty/pagerduty"
      version = ">= 1.9.5"
    }
  }
}

terraform {
  backend "gcs" {
    bucket = "tf-state-pez"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "rwejlgaard"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "google-beta" {
  project = "rwejlgaard"
}

provider "pagerduty" {
  token = file("./.pagerduty_api_key.txt")
}

