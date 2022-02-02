module "ssh_config" {
  source = "../../modules/ssh_config"

  name         = local.server.nickname
  ipv4_address = local.server.ipv4_address
}

output "fqdn" {
  value = local.server.fqdn
}

output "ipv4" {
  value = local.server.ipv4_address
}

output "name" {
  value = local.server.nickname
}
