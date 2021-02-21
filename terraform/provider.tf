provider "google" {
  project = "rwejlgaard"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "google-beta" {
  project = "rwejlgaard"
}

terraform {
  backend "gcs" {
    bucket = "tf-state-pez"
    prefix = "terraform/state"
  }
}
