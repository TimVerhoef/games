resource "hcloud_firewall" "generic" {
  name = local.firewall.generic

  apply_to {
    server = hcloud_server.gameserver.id
  }

  rule {
    description = "ssh"
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips  = var.src.ipv4
  }
}
