source "digitalocean" "create" {
  api_token     = var.token.digital_ocean
  image         = var.digital_ocean.image
  region        = var.digital_ocean.region
  size          = var.digital_ocean.size
  ssh_username  = var.common.ssh_username
  droplet_name  = local.build_vm_name
  snapshot_name = local.snapshot_name
}

source "digitalocean" "update" {
  api_token     = var.token.digital_ocean
  image         = local.snapshot_name
  region        = var.digital_ocean.region
  size          = var.digital_ocean.size
  ssh_username  = var.common.ssh_username
  droplet_name  = local.build_vm_name
  snapshot_name = local.snapshot_name
}

source "hcloud" "create" {
  token           = var.token.hetzner_cloud
  image           = var.hetzner_cloud.image
  location        = var.hetzner_cloud.location
  server_type     = var.hetzner_cloud.server_type
  ssh_username    = var.common.ssh_username
  server_name     = local.build_vm_name
  snapshot_name   = local.snapshot_name
  snapshot_labels = {
    "action": "create"
    "name": local.snapshot_name
  }
}

source "hcloud" "update" {
  token           = var.token.hetzner_cloud
  image_filter {
    with_selector = ["name=${local.snapshot_name}"]
    most_recent   = true
  }
  location        = var.hetzner_cloud.location
  server_type     = var.hetzner_cloud.server_type
  ssh_username    = var.common.ssh_username
  server_name     = local.build_vm_name
  snapshot_name   = local.snapshot_name
  snapshot_labels = {
    "action": "update"
    "name": local.snapshot_name
  }
}

source "openstack" "fuga_cloud_create" {
  application_credential_id     = var.credential.fuga_cloud.app_id
  application_credential_secret = var.credential.fuga_cloud.secret

  networks          = [var.fuga_cloud.network]
  security_groups   = [var.fuga_cloud.security_group]
  flavor            = var.fuga_cloud.flavor
  identity_endpoint = var.fuga_cloud.identity_endpoint
  region            = var.fuga_cloud.region
  source_image_name = var.fuga_cloud.source_image_name
  ssh_username      = var.fuga_cloud.ssh_username
  image_name        = local.snapshot_name
  instance_name     = local.build_vm_name
}

#source "openstack" "fuga_cloud_update" {
#  source_image_filter {
#  }
#}
