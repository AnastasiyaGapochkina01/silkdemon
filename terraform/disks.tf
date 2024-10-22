resource "yandex_compute_disk" "boot-disk1" {
  name = "boot-disk-1"
  type = "network-hdd"
  zone = "ru-central1-b"
  size = "20"
  image_id = "${var.default_image}"
}
