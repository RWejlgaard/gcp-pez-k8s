resource "random_id" "root-password" {
  byte_length = 32
}

resource "google_sql_database_instance" "pez-db" {
  name             = "pez-db"
  database_version = "MYSQL_8_0"
  root_password = random_id.root-password.id
  region = "europe-west1"

  settings {
    tier = "db-f1-micro"
    disk_size = 50
    ip_configuration {
       ipv4_enabled = true
      authorized_networks {
        name = "vpn"
        value = "${google_compute_address.static.address}/32"
      }
    }
  }
}

resource "cloudflare_record" "sql" {
  zone_id = cloudflare_zone.pezsh.id
  name = "sql"
  type = "A"
  value = google_sql_database_instance.pez-db.public_ip_address
  proxied = false
}

resource "kubernetes_secret" "sql-credentials" {
  metadata {
    name = "sql-credentials"
  }

  data = {
    hostname = cloudflare_record.sql.hostname
    username = "root"
    password = random_id.root-password.id
  }

  type = "Opaque"
}

output "sql-password" {
  value = random_id.root-password.id
}