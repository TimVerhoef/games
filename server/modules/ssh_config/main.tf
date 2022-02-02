resource "local_file" "ssh_config" {
  directory_permission = "0700"
  file_permission      = "0600"
  filename             = pathexpand("~/.ssh/config.d/${var.name}")
  content              = templatefile("${path.module}/files/ssh_config.template", {
    name         = var.name,
    ipv4_address = var.ipv4_address,
  })
}
