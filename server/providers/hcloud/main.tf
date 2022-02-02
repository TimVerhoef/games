data "hcloud_images" "snapshot" {
  most_recent = true
  with_status = ["available"]
  with_selector = "name=${local.image.name}"
}

data "hcloud_ssh_keys" "default" {
}

resource "tls_private_key" "terraform" {
  algorithm = "ECDSA"
  ecdsa_curve = "P256"
}

resource "hcloud_ssh_key" "terraform" {
  name = local.server_name
  public_key = tls_private_key.terraform.public_key_openssh
}

locals {
  ssh_keys = distinct(
               concat(
                 data.hcloud_ssh_keys.default.ssh_keys[*].id,
                 [hcloud_ssh_key.terraform.id]
               )
             )
}

resource "hcloud_server" "gameserver" {
  image       = data.hcloud_images.snapshot.images[0].id
  name        = local.server_name
  ssh_keys    = local.ssh_keys
  location    = var.location
  server_type = var.server_type
  labels      = {game = var.game}
}

resource "null_resource" "copy_keys_to_me" {
  connection {
    type = "ssh"
    host = local.server.ipv4_address
    private_key = tls_private_key.terraform.private_key_pem
  }

  provisioner "file" {
    content = tls_private_key.terraform.public_key_openssh
    destination = "/home/me/.ssh/authorized_keys"
  }
}
