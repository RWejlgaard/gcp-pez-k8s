resource "google_compute_network" "default" {
  name = "default"
  description = "Default network for the project"
}

resource "google_compute_firewall" "egress" {
  name = "allegress"
  network = google_compute_network.default.name
  direction = "EGRESS"

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "vpn" {
  network = google_compute_network.default.name
  name    = "vpn"
  source_ranges = ["0.0.0.0/0"]

  target_tags = [
    "vpn-server"
  ]

  allow {
    protocol = "tcp"
    ports    = ["1194"]
  }

  allow {
    protocol = "udp"
    ports    = ["1194"]
  }
}