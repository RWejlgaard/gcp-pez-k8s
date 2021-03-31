resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "vpn" {
  name         = "vpn"
  machine_type = "e2-micro"

  deletion_protection = true

  tags = [
    "vpn-server"
  ]

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
      size = 10
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.service_account.email
    scopes = ["cloud-platform"]
  }
}

resource "cloudflare_record" "vpn" {
  zone_id = cloudflare_zone.pezsh.id
  name = "vpn"
  type = "A"
  value = google_compute_address.static.address
}

output "vpn-ip" {
  value = google_compute_address.static.address
}