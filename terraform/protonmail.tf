resource "cloudflare_record" "mx-mail" {
  zone_id = cloudflare_zone.pezsh.id
  name = "pez.sh"
  type = "MX"
  value = "mail.protonmail.ch"
}

resource "cloudflare_record" "mx-mailsec" {
  zone_id = cloudflare_zone.pezsh.id
  name = "pez.sh"
  type = "MX"
  value = "mailsec.protonmail.ch"
}

resource "cloudflare_record" "txt-dmarc" {
  zone_id = cloudflare_zone.pezsh.id
  name = "_dmarc"
  type = "TXT"
  value = "v=DMARC1; p=none; rua=mailto:pez@pez.sh"
}

resource "cloudflare_record" "txt-spf" {
    zone_id     = cloudflare_zone.pezsh.id
    name        = "pez.sh"
    type        = "TXT"
    value       = "v=spf1 include:_spf.protonmail.ch mx ~all"
}

resource "cloudflare_record" "cname-dkim" {
    for_each = toset(["protonmail", "protonmail2", "protonmail3"])
    zone_id     = cloudflare_zone.pezsh.id
    name        = "${each.key}._domainkey"
    type        = "CNAME"
    value       = "${each.key}.domainkey.dvhicmobdgm7kr3lrey3onoqgn6tqsfiut7ecetqtlzlu2b3c2l7q.domains.proton.ch"
}

resource "cloudflare_record" "txt-verification" {
  zone_id = cloudflare_zone.pezsh.id
  name = "pez.sh"
  type = "TXT"
  value = "protonmail-verification=155e9262046dc386cbc7c1b52b58977b856d32bc"
}