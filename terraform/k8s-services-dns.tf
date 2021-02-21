data "kubernetes_service" "pezsh" {
  metadata {
    name = "pezsh"
    namespace = "web"
  }
}

data "kubernetes_service" "redis" {
  metadata {
    name = "redis"
    namespace = "redis"
  }
}

data "kubernetes_service" "afp" {
  metadata {
    name = "afp"
    namespace = "files"
  }
}

resource "google_dns_record_set" "pezsh-root-service" {
  name = google_dns_managed_zone.pez-zone.dns_name
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.pez-zone.name
  rrdatas = [data.kubernetes_service.pezsh.status[0].load_balancer[0].ingress[0].ip]
}

resource "google_dns_record_set" "pezsh-service" {
  name = "www.${google_dns_managed_zone.pez-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.pez-zone.name
  rrdatas = [data.kubernetes_service.pezsh.status[0].load_balancer[0].ingress[0].ip]
}

resource "google_dns_record_set" "redis-service" {
  name = "redis.${google_dns_managed_zone.pez-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.pez-zone.name
  rrdatas = [data.kubernetes_service.redis.status[0].load_balancer[0].ingress[0].ip]
}

resource "google_dns_record_set" "afp-service" {
  name = "afp.${google_dns_managed_zone.pez-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.pez-zone.name
  rrdatas = [data.kubernetes_service.afp.status[0].load_balancer[0].ingress[0].ip]
}