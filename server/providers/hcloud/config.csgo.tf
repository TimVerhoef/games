locals {
  configure_csgo = var.game == "csgo"
}

resource "hcloud_firewall" "csgo" {
  count = local.configure_csgo ? 1 : 0
  name = "Counter-Strike: Global Offensive"

  apply_to {
    server = hcloud_server.gameserver.id
  }

  rule {
    description = "csgo: rcon"
    direction   = "in"
    protocol    = "tcp"
    port        = "27015"
    source_ips  = ["0.0.0.0/0"]
  }
  rule {
    description = "csgo: game"
    direction   = "in"
    protocol    = "udp"
    port        = "27015"
    source_ips  = ["0.0.0.0/0"]
  }
  rule {
    description = "csgo: source tv"
    direction   = "in"
    protocol    = "udp"
    port        = "27020"
    source_ips  = ["0.0.0.0/0"]
  }
}
