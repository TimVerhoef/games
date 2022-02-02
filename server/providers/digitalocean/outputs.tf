module "ssh_config" {
  source = "../../modules/ssh_config"

  name         = local.name
  ipv4_address = local.ipv4_address
}

output "fqdn" {
  value = local.fqdn
}

output "ipv4" {
  value = local.ipv4_address
}

output "name" {
  value = local.name
}
