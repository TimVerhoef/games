data "digitalocean_droplet_snapshot" "image" {
  name        = var.image_name
  region      = var.region
  most_recent = true
}

data "digitalocean_volume_snapshot" "gamedata" {
  name        = local.volume_name
  region      = var.region
  most_recent = true
}

data "digitalocean_ssh_keys" "all" {
  sort {
    key       = "id"
    direction = "asc"
  }
}
