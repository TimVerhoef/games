build {
  name = "gameserver"

  sources = [
    "source.digitalocean.create",
    "source.digitalocean.update",
    "source.hcloud.create",
    "source.hcloud.update",
    "source.openstack.fuga_cloud_create"
  ]

  provisioner "ansible" {
    host_alias = local.build_vm_name
    playbook_file = "image/ansible/playbooks/${var.action}.yaml"
    extra_arguments = [
      "--extra-vars", "game=${var.game}",
      "--extra-vars", "buildhost=${local.build_vm_name}"
    ]
    ansible_env_vars = [
      "ANSIBLE_STDOUT_CALLBACK=debug"
    ]
    ansible_ssh_extra_args = [
      "-o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa"
    ]
  }
}
