resource "digitalocean_firewall" "default" {
  name        = "default"
  droplet_ids = [digitalocean_droplet.gameserver.id]

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }

  # ssh
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }
}

resource "digitalocean_firewall" "csgo" {
  name = "csgo"
  tags = [digitalocean_tag.csgo.id]

  # csgo: rcon
  inbound_rule {
    protocol         = "tcp"
    port_range       = "27015"
    source_addresses = ["0.0.0.0/0"]
  }
  # csgo: game
  inbound_rule {
    protocol         = "udp"
    port_range       = "27015"
    source_addresses = ["0.0.0.0/0"]
  }
  # csgo: source tv
  inbound_rule {
    protocol         = "udp"
    port_range       = "27020"
    source_addresses = ["0.0.0.0/0"]
  }
}

resource "digitalocean_firewall" "inss" {
  name = "inss"
  tags = [digitalocean_tag.inss.id]

  # inss: game init
  inbound_rule {
    protocol         = "tcp"
    port_range       = "27102"
    source_addresses = ["0.0.0.0/0"]
  }
  # inss: game
  inbound_rule {
    protocol         = "udp"
    port_range       = "27102"
    source_addresses = ["0.0.0.0/0"]
  }
  # inss: query
  inbound_rule {
    protocol         = "udp"
    port_range       = "27131"
    source_addresses = ["0.0.0.0/0"]
  }
  # inss: rcon
  inbound_rule {
    protocol         = "tcp"
    port_range       = "27156"
    source_addresses = ["0.0.0.0/0"]
  }
}
