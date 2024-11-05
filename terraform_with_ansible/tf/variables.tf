terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-b"
}
anestesia@control-plane:~/infra/terraform/examples$ cat variables.tf
variable "service_fqdn" {
  default = "ru-central1.internal"
}

variable "boot_disk_size" {
  default = 15
}

variable "av_zone" {
  default = "ru-central1-b"
}