resource "google_service_account" "service_account" {
  account_id   = "terraform"
  display_name = "terraform"
}

resource "google_container_cluster" "k8s" {
  provider = google-beta
  name               = "k8s"
  location           = "europe-west1-c"
  remove_default_node_pool = true
  initial_node_count = 1
  release_channel {
    channel = "RAPID"
  }
  addons_config {
    istio_config {
      disabled = false
    }
  }
}

resource "google_container_node_pool" "k8s-nodes" {
  name       = "k8s-pool"
  location   = "europe-west1-c"
  cluster    = google_container_cluster.k8s.name
  node_count = 3

  node_config {
    machine_type = "e2-standard-2"
    preemptible = true
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.service_account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

