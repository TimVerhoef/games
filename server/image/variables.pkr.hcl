variable "action" {
  type = string
}

variable "game" {
  type = string
}

variable "credential" {
  type = map(map(string))
  sensitive = true
}

variable "token" {
  type = map(string)
  sensitive = true
}

variable "common" {
  type = map(string)
}

variable "digital_ocean" {
  type = map(string)
}

variable "fuga_cloud" {
  type = map(string)
}

variable "hetzner_cloud" {
  type = map(string)
}
