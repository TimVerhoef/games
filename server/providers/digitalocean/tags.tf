resource "digitalocean_tag" "game" {
  name = var.game
}

resource "digitalocean_tag" "csgo" {
  name = "csgo"
}

resource "digitalocean_tag" "inss" {
  name = "inss"
}
