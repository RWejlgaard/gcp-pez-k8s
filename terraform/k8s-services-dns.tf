data "kubernetes_service" "ingress" {
  metadata {
    name = "istio-ingressgateway"
    namespace = "istio-system"
  }
}

resource "google_dns_record_set" "pezsh-root-domain" {
  name = google_dns_managed_zone.pez-zone.dns_name
  type = "A"
  ttl  = 60

  managed_zone = google_dns_managed_zone.pez-zone.name
  rrdatas = [data.kubernetes_service.ingress.status[0].load_balancer[0].ingress[0].ip]
}

resource "google_dns_record_set" "pezsh-wildcard-domain" {
  name = "*.${google_dns_managed_zone.pez-zone.dns_name}"
  type = "A"
  ttl  = 60

  managed_zone = google_dns_managed_zone.pez-zone.name
  rrdatas = [data.kubernetes_service.ingress.status[0].load_balancer[0].ingress[0].ip]
}