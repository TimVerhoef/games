resource "digitalocean_volume" "gamedata" {
  snapshot_id = data.digitalocean_volume_snapshot.gamedata.id
  name        = local.volume_name
  region      = var.region
  size        = var.volume_size
  tags        = [digitalocean_tag.game.id]
}
