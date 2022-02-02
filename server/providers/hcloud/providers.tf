terraform {
  required_version = ">= 0.13"
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.32.2"
    }
    hetznerdns = {
      source  = "timohirt/hetznerdns"
      version = "~> 1.2.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.1.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.1.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 3.1.0"
    }
    scratch = {
      source = "BrendanThompson/scratch"
      version = "~> 0.1.1"
    }
  }
}

provider "hcloud" {
  token = var.token.hcloud
}

provider "hetznerdns" {
  apitoken = var.token.hetznerdns
}
