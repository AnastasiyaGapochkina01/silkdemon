resource "yandex_compute_instance" "test-vm2" {
  name = "testvm2"
  platform_id = "standard-v1"
  zone = "${var.av_zone}"

  resources {
    cores = "2"
    memory = "2"
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-vm2.id
  }

  network_interface {
    subnet_id = "e2lcmpigub6jp4jl52n7"
    nat = true
  }

  metadata = {
    fqdn = "vm2.${var.service_fqdn}"
    user-data = "#cloud-config\nusers:\n  - name: anestesia\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("~/.ssh/id_rsa.pub")}"
  }

  connection {
    host = "${self.network_interface.0.ip_address}"
    type = "ssh"
    user = "anestesia"
    private_key = "${file("/home/anestesia/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    script = "scripts/wait-host.sh"
  }

  provisioner "local-exec" {
    command = "cd ../provision && ansible-playbook -u anestesia -i '${self.network_interface.0.ip_address},' setup_docker.yml"
  }
}