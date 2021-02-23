resource "google_dns_managed_zone" "pez-zone" {
  dns_name = "pez.sh."
  name = "pez-zone"
}

resource "google_dns_record_set" "protonmail-spf" {
  name = "@.${google_dns_managed_zone.pez-zone.dns_name}"
  type = "TXT"
  ttl  = 300

  managed_zone = google_dns_managed_zone.pez-zone.name
  rrdatas = [
    "protonmail-verification=155e9262046dc386cbc7c1b52b58977b856d32bc",
    "\"v=spf1\" \"include:_spf.protonmail.ch\" \"mx\" \"~all\""
  ]
}

resource "google_dns_record_set" "protonmail-dmarc" {
  name = "_dmarc.${google_dns_managed_zone.pez-zone.dns_name}"
  type = "TXT"
  ttl  = 300

  managed_zone = google_dns_managed_zone.pez-zone.name
  rrdatas = ["v=DMARC1; p=none; rua=mailto:pez@pez.sh"]
}

resource "google_dns_record_set" "protonmail-dkim" {
  for_each = toset(["protonmail._domainkey", "protonmail2._domainkey", "protonmail3._domainkey"])
  name = "${each.key}.${google_dns_managed_zone.pez-zone.dns_name}"
  type = "CNAME"
  ttl  = 300

  managed_zone = google_dns_managed_zone.pez-zone.name
  rrdatas = ["${each.key}.dvhicmobdgm7kr3lrey3onoqgn6tqsfiut7ecetqtlzlu2b3c2l7q.domains.proton.ch."]
}

resource "google_dns_record_set" "protonmail-mx" {
  name = "@.${google_dns_managed_zone.pez-zone.dns_name}"
  type = "MX"
  ttl  = 3600

  managed_zone = google_dns_managed_zone.pez-zone.name
  rrdatas = [
    "10 mail.protonmail.ch.",
    "20 mailsec.protonmail.ch."
  ]
}