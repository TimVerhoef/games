locals {
  configure_ismc = var.game == "ismc"
}

resource "hcloud_firewall" "ismc" {
  count = local.configure_ismc ? 1 : 0
  name = "Insurgency: Sandstorm [ISMCmod]"

  apply_to {
    server = hcloud_server.gameserver.id
  }

  rule {
    description = "ismc: game init"
    direction   = "in"
    protocol    = "tcp"
    port        = "27102"
    source_ips  = ["0.0.0.0/0"]
  }
  rule {
    description = "ismc: game"
    direction   = "in"
    protocol    = "udp"
    port        = "27102"
    source_ips  = ["0.0.0.0/0"]
  }
  rule {
    description = "ismc: query"
    direction   = "in"
    protocol    = "udp"
    port        = "27131"
    source_ips  = ["0.0.0.0/0"]
  }
  rule {
    description = "ismc: rcon"
    direction   = "in"
    protocol    = "tcp"
    port        = "27156"
    source_ips  = ["0.0.0.0/0"]
  }
}

resource "null_resource" "ismc" {
  count = local.configure_ismc ? 1 : 0

  connection {
    user = "me"
    type = "ssh"
    host = local.server.ipv4_address
    private_key = tls_private_key.terraform.private_key_pem
  }

  triggers = {
    ipv4addr = local.server.ipv4_address
    engine   = filesha256(format("../../config/%s/%s", var.game, "Engine.ini.template"))
    server   = filesha256(format("../../config/%s/%s", var.game, "inssserver.cfg.template"))
    rconrc   = filesha256(format("../../config/%s/%s", var.game, "rconrc.template"))
    common   = filesha256(format("../../config/%s/%s", var.game, "common.cfg"))
    admins   = filesha256(format("../../config/%s/%s", var.game, "Admins.txt"))
    mapcycle = filesha256(format("../../config/%s/%s", var.game, "MapCycle.txt"))
    mods     = filesha256(format("../../config/%s/%s", var.game, "Mods.txt"))
    game     = filesha256(format("../../config/%s/%s", var.game, "Game.ini"))
  }

  provisioner "file" {
    content = templatefile(
      format("../../config/%s/%s", var.game, "Engine.ini.template"), {
        token = var.token.mod_io
      }
    )
    destination = format("/home/me/%s/%s", "serverfiles/Insurgency/Saved/Config/LinuxServer", "Engine.ini")
  }

  provisioner "file" {
    content = templatefile(
      format("../../config/%s/%s", var.game, "inssserver.cfg.template"), {
        ipv4_address = local.server.ipv4_address
      }
    )
    destination = "lgsm/config-lgsm/inssserver/inssserver.cfg"
  }

  provisioner "file" {
    content = templatefile(
      format("../../config/%s/%s", var.game, "rconrc.template"), {
        game = var.game
        ipv4_address = local.server.ipv4_address
      }
    )
    destination = ".rconrc"
  }

  provisioner "file" {
    source = format("../../config/%s/%s", var.game, "common.cfg")
    destination = format("/home/me/%s/%s", "lgsm/config-lgsm/inssserver", "common.cfg")
  }

  provisioner "file" {
    source = format("../../config/%s/%s", var.game, "Admins.txt")
    destination = format("/home/me/%s/%s", "serverfiles/Insurgency/Config/Server", "Admins.txt")
  }

  provisioner "file" {
    source = format("../../config/%s/%s", var.game, "MapCycle.txt")
    destination = format("/home/me/%s/%s", "serverfiles/Insurgency/Config/Server", "MapCycle.txt")
  }

  provisioner "file" {
    source = format("../../config/%s/%s", var.game, "Mods.txt")
    destination = format("/home/me/%s/%s", "serverfiles/Insurgency/Config/Server", "Mods.txt")
  }

  provisioner "file" {
    source = format("../../config/%s/%s", var.game, "Game.ini")
    destination = format("/home/me/%s/%s", "serverfiles/Insurgency/Saved/Config/LinuxServer", "Game.ini")
  }

  provisioner "remote-exec" {
    inline = [
      "/usr/games/fortune 1>serverfiles/Insurgency/Config/Server/Motd.txt"
    ]
  }
}
