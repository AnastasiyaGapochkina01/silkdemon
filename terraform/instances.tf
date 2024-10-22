resource "yandex_compute_instance" "project-dev" {
  name = "project-dev-vm1"
  resources {
    cores = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk1.id
  }

  network_interface {
    subnet_id = "${var.default_subnet}"
    nat = true
  }

  metadata = {
    user-data = "${file("${var.cloud_init_file}")}"
  }
}

output "internal_ip_address_project-dev" {
  value = yandex_compute_instance.project-dev.network_interface.0.ip_address
}
