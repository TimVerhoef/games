common = {
  packer_prefix   = "packer-lgsm"
  snapshot_prefix = "linuxgsm"
  ssh_username    = "root"
}

digital_ocean = {
  image  = "debian-11-x64"
  region = "ams3"
  size   = "c-2"
}

fuga_cloud = {
  flavor            = "p2.large"
  identity_endpoint = "https://core.fuga.cloud:5000/v3"
  network           = "093ae4f0-caf5-49ad-9a51-7e29747b7468"
  region            = "ams2"
  security_group    = "sms10"
  source_image_name = "Debian 11"
  ssh_username      = "debian"
}

hetzner_cloud = {
  image       = "debian-11"
  location    = "nbg1"
  server_type = "ccx12"
}
