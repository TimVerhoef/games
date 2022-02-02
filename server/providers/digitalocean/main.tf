resource "digitalocean_droplet" "gameserver" {
  image      = data.digitalocean_droplet_snapshot.image.id
  ssh_keys   = data.digitalocean_ssh_keys.all.ssh_keys[*].id
  name       = local.droplet_name
  region     = var.region
  size       = var.droplet_size
  tags       = [digitalocean_tag.game.id]
  volume_ids = [digitalocean_volume.gamedata.id]

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    private_key = tls_private_key.gameserver.private_key_pem
  }
}
