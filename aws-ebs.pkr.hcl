packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.4"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "region" {
  type    = string
  default = "eu-west-1" # ireland
}

variable "ami_source_id" {
  type    = string
  default = "ami-0715d656023fe21b4" # debian 12 ireland
}

variable "ssh_username" {
  type    = string
  default = "admin"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_name" {
  type    = string
  default = "pierre-ami-cicd"
}

source "amazon-ebs" "app" {
  ami_name      = var.ami_name
  instance_type = var.instance_type
  source_ami    = var.ami_source_id
  region        = var.region
  ssh_username  = var.ssh_username
}

build {
  name = "pierre_build"

  sources = ["source.amazon-ebs.app"]

  provisioner "shell" {
    script = "script/script.sh"
  }
}
