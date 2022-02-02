locals {
  configure_inss = var.game == "inss"
}

resource "hcloud_firewall" "inss" {
  count = local.configure_inss ? 1 : 0
  name = "Insurgency: Sandstorm"

  apply_to {
    server = hcloud_server.gameserver.id
  }

  rule {
    description = "inss: game init"
    direction   = "in"
    protocol    = "tcp"
    port        = "27102"
    source_ips  = ["0.0.0.0/0"]
  }
  rule {
    description = "inss: game"
    direction   = "in"
    protocol    = "udp"
    port        = "27102"
    source_ips  = ["0.0.0.0/0"]
  }
  rule {
    description = "inss: query"
    direction   = "in"
    protocol    = "udp"
    port        = "27131"
    source_ips  = ["0.0.0.0/0"]
  }
  rule {
    description = "inss: rcon"
    direction   = "in"
    protocol    = "tcp"
    port        = "27156"
    source_ips  = ["0.0.0.0/0"]
  }
}

# select a random map and scenario on each sever deployment
locals {
  maps = [
    {
      map = "Bab"
      scenario = "Scenario_Bab_Checkpoint_Insurgents"
    },
    {
      map = "Bab"
      scenario = "Scenario_Bab_Checkpoint_Security"
    },
    {
      map = "Citadel"
      scenario = "Scenario_Citadel_Checkpoint_Insurgents"
    },
    {
      map = "Citadel"
      scenario = "Scenario_Citadel_Checkpoint_Security"
    },
    {
      map = "Canyon"
      scenario = "Scenario_Crossing_Checkpoint_Insurgents"
    },
    {
      map = "Canyon"
      scenario = "Scenario_Crossing_Checkpoint_Security"
    },
    {
      map = "Farmhouse"
      scenario = "Scenario_Farmhouse_Checkpoint_Insurgents"
    },
    {
      map = "Farmhouse"
      scenario = "Scenario_Farmhouse_Checkpoint_Security"
    },
    {
      map = "Gap"
      scenario = "Scenario_Gap_Checkpoint_Insurgents"
    },
    {
      map = "Gap"
      scenario = "Scenario_Gap_Checkpoint_Security"
    },
    {
      map = "Town"
      scenario = "Scenario_Hideout_Checkpoint_Insurgents"
    },
    {
      map = "Town"
      scenario = "Scenario_Hideout_Checkpoint_Security"
    },
    {
      map = "Sinjar"
      scenario = "Scenario_Hillside_Checkpoint_Insurgents"
    },
    {
      map = "Sinjar"
      scenario = "Scenario_Hillside_Checkpoint_Security"
    },
    {
      map = "Ministry"
      scenario = "Scenario_Ministry_Checkpoint_Insurgents"
    },
    {
      map = "Ministry"
      scenario = "Scenario_Ministry_Checkpoint_Security"
    },
    {
      map = "Compound"
      scenario = "Scenario_Outskirts_Checkpoint_Insurgents"
    },
    {
      map = "Compound"
      scenario = "Scenario_Outskirts_Checkpoint_Security"
    },
    {
      map = "Precinct"
      scenario = "Scenario_Precinct_Checkpoint_Insurgents"
    },
    {
      map = "Precinct"
      scenario = "Scenario_Precinct_Checkpoint_Security"
    },
    {
      map = "Oilfield"
      scenario = "Scenario_Refinery_Checkpoint_Insurgents"
    },
    {
      map = "Oilfield"
      scenario = "Scenario_Refinery_Checkpoint_Security"
    },
    {
      map = "Mountain"
      scenario = "Scenario_Summit_Checkpoint_Insurgents"
    },
    {
      map = "Mountain"
      scenario = "Scenario_Summit_Checkpoint_Security"
    },
    {
      map = "PowerPlant"
      scenario = "Scenario_PowerPlant_Checkpoint_Insurgents"
    },
    {
      map = "PowerPlant"
      scenario = "Scenario_PowerPlant_Checkpoint_Security"
    },
    {
      map = "Tell"
      scenario = "Scenario_Tell_Checkpoint_Insurgents"
    },
    {
      map = "Tell"
      scenario = "Scenario_Tell_Checkpoint_Security"
    },
    {
      map = "Buhriz"
      scenario = "Scenario_Tideway_Checkpoint_Insurgents"
    },
    {
      map = "Buhriz"
      scenario = "Scenario_Tideway_Checkpoint_Security"
    },
  ]
}

resource "random_integer" "index" {
  min = 0
  max = length(local.maps)-1
}

locals {
  random = local.maps[resource.random_integer.index.result]
}

resource "null_resource" "inss" {
  count = local.configure_inss ? 1 : 0

  connection {
    user = "me"
    type = "ssh"
    host = local.server.ipv4_address
    private_key = tls_private_key.terraform.private_key_pem
  }

  triggers = {
    ipv4addr = local.server.ipv4_address
    server   = filesha256(format("../../config/%s/%s", var.game, "inssserver.cfg.template"))
    common   = filesha256(format("../../config/%s/%s", var.game, "common.cfg"))
    admins   = filesha256(format("../../config/%s/%s", var.game, "Admins.txt"))
    mapcycle = filesha256(format("../../config/%s/%s", var.game, "MapCycle.txt"))
    mods     = filesha256(format("../../config/%s/%s", var.game, "Mods.txt"))
    game     = filesha256(format("../../config/%s/%s", var.game, "Game.ini"))
  }

  provisioner "file" {
    content = templatefile(
      format("../../config/%s/%s", var.game, "inssserver.cfg.template"), {
        ipv4_address    = local.server.ipv4_address
        random_map      = local.random.map
        random_scenario = local.random.scenario
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
