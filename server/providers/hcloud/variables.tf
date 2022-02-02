variable "domain" {
  type = string
  default = "tv33.nl"
}

variable "image" {
  type = map(string)
}

variable "location" {
  type = string
  default = "nbg1"  # Nuremberg DC (DE)
}

variable "server_type" {
  type = string
  default = "ccx12"  # dedicated/AMD EPYC/2c/8GB/80GB
}

variable "src" {
  type = map(list(string))
  default = {
    ipv4 = [
      "<ip here>/32"
    ]
  }
}

variable "token" {
  sensitive = true
  type = map(string)
}
