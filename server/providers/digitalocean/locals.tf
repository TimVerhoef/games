locals {
  droplet_name = "linuxgsm-${var.game}"
 #volume_name  = "gamedata-${var.game}"
  volume_name  = "steam-data-20210928"
}

locals {
  ipv4_address = digitalocean_droplet.gameserver.ipv4_address
  fqdn         = digitalocean_record.gameserver.fqdn
  name         = "${var.game}-do"
}
