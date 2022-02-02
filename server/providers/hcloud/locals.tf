locals {
  firewall = {
    generic = "Generic (${local.server_name})"
  }

  image = {
    name = "linuxgsm-${var.image.suffix}"
  }

  # the variable for the name of the server must be defined out of the
  #  'server' map, to prevent Terraform Cycle: errors
  server_name = "linuxgsm-${var.game}"

  server = {
    fqdn         = "${hetznerdns_record.gameserver.name}.${var.domain}"
    ipv4_address = hcloud_server.gameserver.ipv4_address
    nickname     = "${var.game}-hc"
  }
}
