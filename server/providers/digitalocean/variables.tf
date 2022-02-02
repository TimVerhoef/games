variable "domain" {
  type = string
}

variable "droplet_size" {
  type = string
}

variable "game" {
  type = string
}

variable "image_name" {
  type = string
}

variable "region" {
  type = string
}

variable "token" {
  sensitive = true
  type = string
}

variable "volume_size" {
  type = string
}
