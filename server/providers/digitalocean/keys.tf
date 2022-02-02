resource "tls_private_key" "gameserver" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "digitalocean_ssh_key" "gameserver" {
  name       = local.droplet_name
  public_key = tls_private_key.gameserver.public_key_openssh
}
