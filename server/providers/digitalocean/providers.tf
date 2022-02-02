terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.16.0"
    }
  }
}

provider "digitalocean" {
  token = var.token
}
