resource "digitalocean_record" "gameserver" {
  name   = var.game
  domain = var.domain
  value  = local.ipv4_address
  type   = "A"
  ttl    = 60
}
