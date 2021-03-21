resource "cloudflare_zone" "pezsh" {
  zone = "pez.sh"

}

data "kubernetes_service" "istio-ingress" {
  metadata {
    name = "istio-ingressgateway"
    namespace = "istio-system"
  }
}

variable "istio-endpoints" {
  default = [
    "pez.sh",
    "www",
    "cloudprober",
    "grafana",
    "prometheus",
    "redis",
    "api"
  ]
}

resource "cloudflare_record" "istio-endpoint" {
  for_each = toset(var.istio-endpoints)
  zone_id = cloudflare_zone.pezsh.id
  name = each.key
  value = data.kubernetes_service.istio-ingress.status[0].load_balancer[0].ingress[0].ip
  type = "A"
  proxied = true
}