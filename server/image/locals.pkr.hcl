locals {
  build_vm_name = "${var.common.packer_prefix}-${var.game}"
  snapshot_name = "${var.common.snapshot_prefix}-${var.game}"
}
