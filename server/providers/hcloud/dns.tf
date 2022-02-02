data "hetznerdns_zone" "domain" {
  name = var.domain
}

resource "hetznerdns_record" "gameserver" {
  # Hetzner Cloud does not support subdomains, so adding the
  #  subdomain to the hostname here to achieve the same goal.
  name    = "${var.game}.hc"
  zone_id = data.hetznerdns_zone.domain.id
  value   = hcloud_server.gameserver.ipv4_address
  type    = "A"
  ttl     = 60
}

resource "hcloud_rdns" "gameserver" {
  server_id  = hcloud_server.gameserver.id
  ip_address = local.server.ipv4_address
  dns_ptr    = local.server.fqdn
}
